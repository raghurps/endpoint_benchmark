require 'logger'

module EndpointBenchmark
  class LogService
    def self.make_from_filename(filename)
      return nil if filename.nil?

      self.new(filename: filename)
    end

    def self.make_from_handle(handle)
      return nil if handle.nil?

      self.new(handle: handle)
    end

    def initialize(**args)
      if args.key?(:filename) && !args[:filename].nil?
        @logger ||= Logger.new(args[:filename])
      elsif !args[:handle].nil? && args[:handle].is_a?(Logger)
        @logger ||= args[:handle]
      end
      @logger.level = (Object.const_get(
                        "Logger::#{ENV['LOG_LEVEL'].upcase}"
                        ) rescue Logger::INFO)
      puts "Log level: #{@logger.level}"
      @verbose = EndpointBenchmark::DEFAULT_VERBOSITY
      if %w[true false].include?(ENV['VERBOSE'].to_s.downcase)
        @verbose = str_to_bool(ENV['VERBOSE'].to_s)
      else
        @verbose = false
      end
    end

    def debug(msg)
      @logger.debug { msg }
      STDOUT.puts "DEBUG: #{msg}" if @verbose
    end

    def info(msg)
      @logger.info msg
      STDOUT.puts "INFO: #{msg}" if @verbose
    end

    def warn(msg)
      @logger.warn msg
      STDOUT.puts "WARN: #{msg}" if @verbose
    end

    def error(msg)
      @logger.error msg
      STDOUT.puts "ERROR: #{msg}"
    end

    def fatal(msg)
      @logger.fatal msg
      STDOUT.puts "FATAL: #{msg}"
    end

    private

    def str_to_bool(val)
      ret = false
      case val.downcase
      when 'true'
        ret = true
      when 'false'
        ret = false
      end

      ret
    end
  end
end
