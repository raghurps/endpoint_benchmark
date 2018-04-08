RSpec.describe EndpointBenchmark::BenchmarkTool do
  let(:fqdn_valid_host1) {'domain.com'}
  let(:fqdn_invalid_host1) {'.domain.com'}
  let(:ip_valid_host1) {'10.10.1.2'}
  let(:ip_valid_host2) {'0.0.0.0'}
  let(:ip_invalid_host1) {'10.1.11.0.9'}

  let(:valid_protocol1) {'http'}
  let(:valid_protocol2) {'https'}
  let(:invalid_protocol1) {'tcp'}
  let(:invalid_protocol2) {'udp'}
  let(:valid_interval) {10}
  let(:invalid_interval) {-10}
  let(:valid_duration) {10}
  let(:invalid_duration) {-10}
  let(:logger) {Logger.new(STDOUT)}

  describe "Return on validation failure" do
    it "should return -1 if invalid fqdn host provided" do
      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: fqdn_invalid_host1, type: valid_protocol1,
        logger: logger, duration: valid_duration,
        interval: valid_interval)).to eq(-1)
    end

    it "should return -1 if invalid ip host provided" do
      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: ip_invalid_host1, type: valid_protocol1,
        logger: logger, duration: valid_duration,
        interval: valid_interval)).to eq(-1)
    end

    it "should return -1 if invalid tcp protocol provided" do
      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: fqdn_valid_host1, type: invalid_protocol1,
        logger: logger, duration: valid_duration,
        interval: valid_interval)).to eq(-1)
    end

    it "should return -1 if invalid udp protocol provided" do
      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: fqdn_valid_host1, type: invalid_protocol2,
        logger: logger, duration: valid_duration,
        interval: valid_interval)).to eq(-1)
    end

    it "should return -1 if invalid interval provided" do
      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: fqdn_valid_host1, type: valid_protocol1,
        logger: logger, duration: valid_duration,
        interval: invalid_interval)).to eq(-1)
    end

    it "should return -1 if invalid interval provided" do
      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: fqdn_valid_host1, type: valid_protocol1,
        logger: logger, duration: valid_duration,
        interval: 0)).to eq(-1)
    end

    it "should return -1 if invalid duration provided" do
      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: fqdn_valid_host1, type: valid_protocol1,
        logger: logger, duration: invalid_duration,
        interval: valid_interval)).to eq(-1)
    end

    it "should return -1 if invalid duration provided" do
      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: fqdn_valid_host1, type: valid_protocol1,
        logger: logger, duration: 0,
        interval: valid_interval)).to eq(-1)
    end

  end

  describe "it should properly report average" do
    it "should return avg 0.000123 if all get request succeed" do
      allow_any_instance_of(EndpointBenchmark::Http).to receive(:get_request).and_return(true)

      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: fqdn_valid_host1, type: valid_protocol1,
        logger: logger, duration: valid_duration,
        interval: valid_interval)).not_to eq(-1)
    end

    it "should return avg -1 if all get request fail" do
      Benchmark = double
      allow(Benchmark).to receive(:realtime) {0.000123}

      expect(EndpointBenchmark::BenchmarkTool.begin_benchmark(
        host: fqdn_valid_host1, type: valid_protocol1,
        logger: logger, duration: valid_duration,
        interval: valid_interval)).to eq(-1)
    end
  end

end
