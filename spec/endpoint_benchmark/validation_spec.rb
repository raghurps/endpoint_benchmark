RSpec.describe EndpointBenchmark::Validation do
  let(:fqdn_valid_host1) { 'domain.com' }
  let(:fqdn_invalid_host1) { '.domain.com' }
  let(:ip_valid_host1) { '10.10.1.2' }
  let(:ip_valid_host2) { '0.0.0.0' }
  let(:ip_invalid_host1) { '10.1.11.0.9' }

  let(:valid_protocol1) { 'http' }
  let(:valid_protocol2) { 'https' }
  let(:invalid_protocol1) { 'tcp' }
  let(:invalid_protocol2) { 'udp' }

  let(:duration) { 60 }
  let(:interval) { 10 }
  let(:logger) { Logger.new(STDOUT) }

  describe 'Validate module methods are responding' do
    it 'should respond to validate method call' do
      expect(EndpointBenchmark::Validation.respond_to?(:validate?)).to eq(true)
    end

    it 'should respond to validate_endpoint method call' do
      expect(EndpointBenchmark::Validation.respond_to?(:validate_endpoint?)).to eq(true)
    end

    it 'should respond to validate_protocol method call' do
      expect(EndpointBenchmark::Validation.respond_to?(:validate_protocol?)).to eq(true)
    end

    it 'should have VALIDATOR hash' do
      expect(EndpointBenchmark::Validation::VALIDATOR.respond_to?(:fetch)).to eq(true)
    end
  end

  describe 'should validate host addr' do
    it 'validate_endpoint should weed out invalid fqdn host addr' do
      expect(EndpointBenchmark::Validation.
             validate_endpoint?(fqdn_invalid_host1)).to eq(false)
    end

    it 'validate_endpoint should weed out invalid ip host addr' do
      expect(EndpointBenchmark::Validation.
             validate_endpoint?(ip_invalid_host1)).to eq(false)
    end

    it 'validate_endpoint should allow valid fqdn host addr' do
      expect(EndpointBenchmark::Validation.
             validate_endpoint?(fqdn_valid_host1)).to eq(true)
    end

    it 'validate_endpoint should allow valid ip host addr' do
      expect(EndpointBenchmark::Validation.
             validate_endpoint?(ip_valid_host1)).to eq(true)
    end
  end

  describe 'should validate protocol' do
    it 'validate_protocol should weed out invalid tcp protocol' do
      expect(EndpointBenchmark::Validation.
             validate_protocol?(invalid_protocol1)).to eq(false)
    end

    it 'validate_protocol should weed out invalid udp protocol' do
      expect(EndpointBenchmark::Validation.
             validate_protocol?(invalid_protocol2)).to eq(false)
    end

    it 'validate_protocol should allow valid http protocol' do
      expect(EndpointBenchmark::Validation.
             validate_protocol?(valid_protocol1)).to eq(true)
    end

    it 'validate_protocol should allow valid https protocol' do
      expect(EndpointBenchmark::Validation.
             validate_protocol?(valid_protocol2)).to eq(true)
    end
  end

  describe 'should validate duration' do
    it 'should disallow negative duration' do
      expect(EndpointBenchmark::Validation.
             validate?(host: fqdn_valid_host1, type: valid_protocol1,
                       interval: interval, duration: -1,
                      logger: logger)).to eq(false)
    end

    it 'should disallow nil duration' do
      expect(EndpointBenchmark::Validation.
             validate?(host: fqdn_valid_host1, type: valid_protocol1,
                       interval: interval, duration: nil,
                      logger: logger)).to eq(false)
    end

    it 'should disallow negative interval' do
      expect(EndpointBenchmark::Validation.
             validate?(host: fqdn_valid_host1, type: valid_protocol1,
                       interval: -1, duration: duration,
                      logger: logger)).to eq(false)
    end

    it 'should disallow nil interval' do
      expect(EndpointBenchmark::Validation.
             validate?(host: fqdn_valid_host1, type: valid_protocol1,
                       interval: nil, duration: duration,
                      logger: logger)).to eq(false)
    end
  end
end
