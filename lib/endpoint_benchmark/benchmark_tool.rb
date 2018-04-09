require 'benchmark'
require 'json'

module EndpointBenchmark
  # BenchmarkTool module to perform benchmark
  module BenchmarkTool
    def self.begin_benchmark(**args)
      logger = (args[:logger] ||
                   EndpointBenchmark::LogService.make_from_file(
                     "#{Dir.pwd}/#{EndpointBenchmark::DEFAULT_LOG_FILE}"
                   )
               )

      args[:logger] ||= logger # Ensuring logger key has value

      return -1 unless EndpointBenchmark::Validation.validate?(args)

      logger.info "Args: #{JSON.pretty_generate(args)}"

      req_obj = Object.const_get(
                  "EndpointBenchmark::#{args[:type].split('_')
                  .collect(&:capitalize).join}"
                                ).make_from_args(args)

      return -1 if req_obj.nil?
      # Adding 1 to ensure that the begining and
      # the end time are inclusive in the duration.
      iterations = (args[:duration] / args[:interval]).to_i + 1

      threads = []
      results = {}

      iterations.times do |i|
        results[i.to_s] = {}
        logger.debug "Spawning Thread #{i + 1} at #{Time.now}"
        threads << Thread.new do
          Benchmark.realtime do
            results[i.to_s]['success'] = req_obj.get_request
          end
        end
        sleep(args[:interval])
      end

      threads.each_with_index do |t, i|
        logger.debug "Joining Thread #{i + 1}"
        t.join

        logger.debug "Request took #{t.value}s"
        results[i.to_s]['value'] = t.value
      end

      logger.info "Response time for requests = #{results}"

      sum = 0
      count = 0
      results.each do |_, v|
        next unless v['success']

        sum += v['value']
        count += 1
      end

      avg = -1
      avg = sum / count.to_f if count != 0

      logger.info "Average Response time is: #{avg}"

      avg
    end
  end
end
