require 'uri'
require 'net/http'

class EndpointBenchmark::Http

  SELF_SIGNED_CERTIFICATE = false

  def self.make_from_args(**args)
    if args[:url].present?
      return self.new(args)
    else
      return nil
    end
  end

  def initialize(**args)
    begin
      uri = URI(args[:url])
      args[:self_signed] ||= SELF_SIGNED_CERTIFICATE
      @http = Net::HTTP.new(uri.host, uri.port)
      @http.open_timeout = 5
    
      if url.include?('https:')
        @http.use_ssl = true
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE if args[:self_signed]
      end
    rescue StandardError => e
      puts "Initialization failed!"
      puts e.inspect
    end
  end

  private

  attr_accessor :http

  def try_head_request
    request = Net::HTTP::Head.new('/')
    response = http.request(request)

    if response.code.to_i < 400
      puts "Site is Up! :)"
    else
      puts "Site is down! :("
    end
  end

  def try_get_request
    request = Net::HTTP::Get.new('/')
    response = http.request(request)

    if response.code.to_i < 400
      puts "Site is Up! :)"
    else
      puts "Site is down! :("
    end
  end
end
