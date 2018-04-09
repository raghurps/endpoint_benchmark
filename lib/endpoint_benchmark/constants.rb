require 'resolv'

module EndpointBenchmark
  ENDPOINT_FQDN_REGEX = /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}$/
  ENDPOINT_IP_REGEX = Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex)

  SELF_SIGNED_CERTIFICATE = false
  SUPPORTED_PROTOCOLS = %w[https http].freeze
  DEFAULT_PROTOCOL = 'https'.freeze
  DEFAULT_HOST = 'gitlab.com'.freeze
  DEFAULT_INTERVAL = 10
  DEFAULT_DURATION = 60
  DEFAULT_VERBOSITY = false

  DEFAULT_LOG_FILE = 'endpoint_benchmark.log'.freeze
end
