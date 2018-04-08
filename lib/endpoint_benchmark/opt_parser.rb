require 'optparse'

module EndpointBenchmark
  class OptParser
    def self.parse(args, options={})
      proceed = true
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: benchmark [options] [host]\n"+ 
          "Defaults: benchmark -t https -i 10 -d 60 -n gitlab.com"
        opts.on("-t", "--type TRANSPORT", String, "Transport type") do |v|
          options[:type] = v
        end
        opts.on("-i", "--interval INTERVAL", Integer,
                "Interval over which to retry benchmarking") do |v|
          options[:interval] = v
        end
        opts.on("-d", "--duration DURATION", Integer,
                "Duration over which benchmark iteration resides") do |v|
          options[:duration] = v
        end
        opts.on("-n", "--hostname MYDOMAIN.COM",
          "Host to perform benchmark") do |v|
          options[:host] = v
        end
        opts.on("-v", "--[no-]verbose", "Run command in verbose mode") do |v|
          options[:verbose] = v
        end
        opts.on("-h", "--help", "Show this help message") do ||
          puts opts
          options = {}
          proceed = false
        end
        opts.on("--[no-]insecure", "Use this option for self-signed certificate") do |v|
          options[:self_signed] = v
        end
        opts.on("--version", "Show version") do ||
          puts EndpointBenchmark::VERSION
          options = {}
          proceed = false
        end
      end

      opts.parse!(args)

      # Set default values
      if proceed
        options[:type] ||= EndpointBenchmark::DEFAULT_PROTOCOL
        options[:host] ||= EndpointBenchmark::DEFAULT_HOST
        options[:interval] ||= EndpointBenchmark::DEFAULT_INTERVAL
        options[:duration] ||= EndpointBenchmark::DEFAULT_DURATION
        options[:verbose] ||= EndpointBenchmark::DEFAULT_VERBOSITY
        options[:self_signed] ||= EndpointBenchmark::SELF_SIGNED_CERTIFICATE
      end

      options
    end
  end
end
