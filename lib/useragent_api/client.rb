require 'cgi'
require 'json'
require 'net/https'

module UseragentApi
  class Client
    # @param api_key [String] UseragentAPI API key
    # @raise [ArgumentError] when `api_key` is invalid
    # @see https://useragentapi.com/docs/v4
    def initialize(api_key)
      raise ArgumentError, 'invalid API key' if api_key.empty?
      @api_key = api_key.freeze
      freeze
    end

    # @return [String] Returns the api key
    attr_reader :api_key

    # Parse an useragent using UseragenAPI
    #
    # @param useragent [String] an useragent
    # @return [Hash] a Hash generated by parsing the JSON returned
    #   from the API call, just `{}` on parsing failure
    def parse(useragent)
      response = request(useragent)
      parse_as_json(response.body)
    end

    USERAGENT_API_FQDN = URI('https://useragentapi.com/')
    private_constant :USERAGENT_API_FQDN

    USER_AGENT = 'UseragentApi gem/%s' % VERSION
    private_constant :USER_AGENT

    private

    def request(useragent)
      uri = request_uri(useragent)
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.get(uri.path, 'User-Agent' => USER_AGENT)
      end
    end

    def request_uri(useragent)
      USERAGENT_API_FQDN.dup.tap do |uri|
        uri.path = '/api/v4/json/%s/%s' % [api_key, CGI.escape(useragent)]
      end
    end

    def parse_as_json(json_text)
      json_text ||= '{}'
      JSON.parse(json_text)
    rescue JSON::ParserError
      {}
    end
  end
end
