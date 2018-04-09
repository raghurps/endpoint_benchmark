RSpec.describe EndpointBenchmark::LogService do
  let(:filename) { STDOUT }
  let(:handle) { Logger.new(STDOUT) }

  it 'should make log service from filename' do
    expect(EndpointBenchmark::LogService.make_from_filename(filename)).
                                              to_not eq(nil)
  end

  it 'should make log service from filename with verbosity enabled' do
    stub_const('EndpointBenchmark::DEFAULT_VERBOSITY', true)
    expect(EndpointBenchmark::DEFAULT_VERBOSITY).to eq(true)

    expect(EndpointBenchmark::LogService.make_from_filename(filename)).
                                              to_not eq(nil)
  end

  it 'shouldn\'t make log service without filename' do
    expect(EndpointBenchmark::LogService.make_from_filename(nil)).
                                              to eq(nil)
  end

  it 'should make log service from handle' do
    expect(EndpointBenchmark::LogService.make_from_handle(handle)).
                                              to_not eq(nil)
  end

  it 'should make log service from handle with verbosity enabled' do
    stub_const('EndpointBenchmark::DEFAULT_VERBOSITY', true)
    expect(EndpointBenchmark::DEFAULT_VERBOSITY).to eq(true)

    expect(EndpointBenchmark::LogService.make_from_handle(handle)).
                                              to_not eq(nil)
  end

  it 'shouldn\'t make log service without handle' do
    expect(EndpointBenchmark::LogService.make_from_handle(nil)).
                                              to eq(nil)
  end
end
