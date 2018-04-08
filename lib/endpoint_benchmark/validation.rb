module EndpointBenchmark
  module Validation

    def self.validate?(**args)
			logger = args[:logger]
      args.each do |k,v|
				logger.debug "Validating key [#{k}] with value [#{v}]"

				unless VALIDATOR.fetch(k, -> (*_) {true}).(args)
					logger.error "Invalid #{k.to_s} value [#{v.to_s}]!"
					return false
				end
      end

			return true
    end

		VALIDATOR = {
			host: -> (val) {
				self.validate_endpoint?(val[:host])
			},
			type: -> (val) {
				self.validate_protocol?(val[:type])
			},
			interval: -> (val) {
				(!val[:interval].nil? && val[:interval] > 0)
			},
			duration: -> (val) {
				(!val[:duration].nil? && val[:duration] > 0)
			}
		}

    def self.validate_endpoint?(ep)
      # Must be of form mydomain.domain.com or 10.21.12.21
      # i.e. IP address of FQDN
      return false if ep.empty?

      if (ep =~ EndpointBenchmark::ENDPOINT_FQDN_REGEX) ||
        (ep =~ EndpointBenchmark::ENDPOINT_IP_REGEX)
        return true
      end

      return false
    end

    def self.validate_protocol?(proto)
      EndpointBenchmark::SUPPORTED_PROTOCOLS.include?(proto)
    end

  end
end
