RSpec.describe EndpointBenchmark::OptParser do
  let(:default_opts) { {type: EndpointBenchmark::DEFAULT_PROTOCOL,
          host: EndpointBenchmark::DEFAULT_HOST,
          interval: EndpointBenchmark::DEFAULT_INTERVAL,
          duration: EndpointBenchmark::DEFAULT_DURATION,
          verbose: EndpointBenchmark::DEFAULT_VERBOSITY,
          self_signed: EndpointBenchmark::SELF_SIGNED_CERTIFICATE
  } }


  it 'should return default Hash if no options provided' do
    expect(EndpointBenchmark::OptParser.parse([])).to eq(default_opts)
  end

  it 'should return empty Hash if asked for version' do
    expect(EndpointBenchmark::OptParser.parse(['--version'])).to eq({})
  end

  it 'should return empty Hash if asked for help' do
    expect(EndpointBenchmark::OptParser.parse(['--help'])).to eq({})
  end
end
