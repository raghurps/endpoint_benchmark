require 'uri'
require 'net/http'

module EndpointBenchmark
  # Custom HTTP class
  class Http
    def self.make_from_args(**args)
      ret_obj = nil
      if !args[:host].nil? && !args[:type].nil? &&
         %w[http https].include?(args[:type]) &&
         !args[:logger].nil?
        ret_obj = EndpointBenchmark::Http.new(args)
      end

      ret_obj
    end

    def initialize(**args)
      # initialize logger
      @logger ||= args[:logger]

      begin
        url = args[:type] + '://' + args[:host]
        uri = URI(url)
        args[:self_signed] ||= EndpointBenchmark::SELF_SIGNED_CERTIFICATE
        @http = Net::HTTP.new(uri.host, uri.port)
        # @http.open_timeout = 5

        if url.include?('https:')
          @http.use_ssl = true
          @http.verify_mode = OpenSSL::SSL::VERIFY_NONE if args[:self_signed]
        end

        @logger.info "Initialized HTTP object for URL: [#{url}]"
      rescue StandardError => e
        @logger.error 'Initialization failed!'
        @logger.error e.inspect
      end
    end

    def head_request
      try_head_request
    end

    def get_request
      try_get_request
    end

    private

    attr_accessor :http, :logger

    def try_head_request
      # Returning true or false based on successful
      # http connection
      success = false
      begin
        request = Net::HTTP::Head.new('/')

        logger.debug "Sending HTTP HEAD request: #{request}"
        response = http.request(request)

        logger.debug "Got [#{response.code}] response for HEAD \
          request [#{request}]: #{response.body}"
        logger.info "Site responded with code: [#{response.code.to_i}]! :)"
        success = true
      rescue StandardError => e
        logger.error 'HEAD request failed!'
        logger.error e.inspect
      end

      success
    end

    def try_get_request
      # Returning true or false based on successful
      # http connection
      success = false
      begin
        request = Net::HTTP::Get.new('/')

        logger.debug "Sending HTTP GET request: #{request}"
        response = http.request(request)

        logger.debug "Got [#{response.code}] response for GET request \
          [#{request}]: #{response.body}"
        logger.info "Site responded with code: [#{response.code.to_i}]! :)"
        success = true
      rescue StandardError => e
        logger.error 'HEAD request failed!'
        logger.error e.inspect
      end

      success
    end
  end

  Https = Http
end
