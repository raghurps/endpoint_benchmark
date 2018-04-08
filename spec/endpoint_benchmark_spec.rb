RSpec.describe EndpointBenchmark do
  it "has a version number" do
    expect(EndpointBenchmark::VERSION).not_to be nil
  end

  it "has a default log file name" do
    expect(EndpointBenchmark::DEFAULT_LOG_FILE).not_to be nil
  end

  it "should load Http class object" do
    expect(EndpointBenchmark::Http.respond_to?(:new)).to eq(true)
  end

  it "should load Https class object" do
    expect(EndpointBenchmark::Https.respond_to?(:new)).to eq(true)
  end

  it "should load LogService class object" do
    expect(EndpointBenchmark::LogService.respond_to?(:new)).to eq(true)
  end

  it "should load OptParser module" do
    expect(EndpointBenchmark::OptParser.respond_to?(:parse)).to eq(true)
  end

  it "should load Validation module" do
    expect(EndpointBenchmark::Validation.respond_to?(:validate?)).to eq(true)
  end

  it "should load BenchmarkTool module" do
    expect(EndpointBenchmark::BenchmarkTool.respond_to?(:begin_benchmark)).to eq(true)
  end

end
