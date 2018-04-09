RSpec.describe EndpointBenchmark::Http do
  let(:fqdn_valid_host1) { 'domain.com' }
  let(:fqdn_invalid_host1) { '.domain.com' }
  let(:ip_valid_host1) { '10.10.1.2' }
  let(:ip_valid_host2) { '0.0.0.0' }
  let(:ip_invalid_host1) { '10.1.11.0.9' }

  let(:valid_protocol1) { 'http' }
  let(:valid_protocol2) { 'https' }
  let(:invalid_protocol1) { 'tcp' }
  let(:invalid_protocol2) { 'udp' }
  let(:logger) { Logger.new(STDOUT) }
  

  describe 'Valid protocols' do
    it 'should be valid with http protocol' do
      expect(EndpointBenchmark::Http.make_from_args(host: fqdn_valid_host1,
                                                    type: valid_protocol1,
                                                    logger: logger)).
                                                    to_not eq(nil)
    end

    it 'should be valid with https protocol' do
      expect(EndpointBenchmark::Http.make_from_args(host: fqdn_valid_host1,
                                                    type: valid_protocol2,
                                                    logger: logger)).
                                                    to_not eq(nil)
    end

    it 'should be nil with tcp protocol' do
      expect(EndpointBenchmark::Http.make_from_args(host: fqdn_valid_host1,
                                                    type: invalid_protocol1,
                                                    logger: logger)).
                                                    to eq(nil)
    end

    it 'should be nil with udp protocol' do
      expect(EndpointBenchmark::Http.make_from_args(host: fqdn_valid_host1,
                                                    type: invalid_protocol2,
                                                    logger: logger)).
                                                    to eq(nil)
    end
  end

  describe 'HTTP GET' do
    it 'should respond to get_request' do
      expect(EndpointBenchmark::Http.make_from_args(host: fqdn_valid_host1,
                                                    type: valid_protocol1,
                                                    logger: logger).respond_to?(
                                                      :get_request)).to eq(true)
    end

    it 'should raise error if invalid fqdn host provided' do
      allow(EndpointBenchmark::Http.make_from_args(host: fqdn_invalid_host1,
                                                    type: valid_protocol1,
                                                    logger: logger)).to receive(
                                                      :get_request).
                                                    and_raise(StandardError)
    end

    it 'should raise error if invalid ip host provided' do
      allow(EndpointBenchmark::Http.make_from_args(host: ip_invalid_host1,
                                                    type: valid_protocol1,
                                                    logger: logger)).to receive(
                                                      :get_request).
                                                    and_raise(StandardError)
    end

    it 'should raise error if nil object provided' do
      allow(EndpointBenchmark::Http.make_from_args(host: fqdn_valid_host1,
                                                    type: invalid_protocol1,
                                                    logger: logger)).to receive(
                                                      :get_request).
                                                    and_raise(StandardError)
    end
  end

  describe 'HTTPS GET' do
    it 'should respond to get_request' do
      expect(EndpointBenchmark::Https.make_from_args(host: fqdn_valid_host1,
                                                    type: valid_protocol2,
                                                    logger: logger).respond_to?(
                                                      :get_request)).to eq(true)
    end

    it 'should raise error if invalid fqdn host provided' do
      allow(EndpointBenchmark::Https.make_from_args(host: fqdn_invalid_host1,
                                                    type: valid_protocol2,
                                                    logger: logger)).to receive(
                                                      :get_request).
                                                    and_raise(StandardError)
    end

    it 'should raise error if invalid ip host provided' do
      allow(EndpointBenchmark::Https.make_from_args(host: ip_invalid_host1,
                                                    type: valid_protocol2,
                                                    logger: logger)).to receive(
                                                      :get_request).
                                                    and_raise(StandardError)
    end

    it 'should raise error if nil object provided' do
      allow(EndpointBenchmark::Https.make_from_args(host: fqdn_valid_host1,
                                                    type: invalid_protocol2,
                                                    logger: logger)).to receive(
                                                      :get_request).
                                                    and_raise(StandardError)
    end
  end

  describe 'HTTP HEAD' do
    it 'should respond to head_request' do
      expect(EndpointBenchmark::Http.make_from_args(host: fqdn_valid_host1,
                                                    type: valid_protocol1,
                                                    logger: logger).respond_to?(
                                                      :head_request)).to eq(true)
    end

    it 'should raise error if invalid fqdn host provided' do
      allow(EndpointBenchmark::Http.make_from_args(host: fqdn_invalid_host1,
                                                    type: valid_protocol1,
                                                    logger: logger)).to receive(
                                                      :head_request).
                                                    and_raise(StandardError)
    end

    it 'should raise error if invalid ip host provided' do
      allow(EndpointBenchmark::Http.make_from_args(host: ip_invalid_host1,
                                                    type: valid_protocol1,
                                                    logger: logger)).to receive(
                                                      :head_request).
                                                    and_raise(StandardError)
    end

    it 'should raise error if nil object provided' do
      allow(EndpointBenchmark::Http.make_from_args(host: fqdn_valid_host1,
                                                    type: invalid_protocol1,
                                                    logger: logger)).to receive(
                                                      :head_request).
                                                    and_raise(StandardError)
    end
  end

  describe 'HTTPS HEAD' do
    it 'should respond to head_request' do
      expect(EndpointBenchmark::Https.make_from_args(host: fqdn_valid_host1,
                                                    type: valid_protocol2,
                                                    logger: logger).respond_to?(
                                                      :head_request)).to eq(true)
    end

    it 'should raise error if invalid fqdn host provided' do
      allow(EndpointBenchmark::Https.make_from_args(host: fqdn_invalid_host1,
                                                    type: valid_protocol2,
                                                    logger: logger)).to receive(
                                                      :head_request).
                                                    and_raise(StandardError)
    end

    it 'should raise error if invalid ip host provided' do
      allow(EndpointBenchmark::Https.make_from_args(host: ip_invalid_host1,
                                                    type: valid_protocol2,
                                                    logger: logger)).to receive(
                                                      :head_request).
                                                    and_raise(StandardError)
    end

    it 'should raise error if nil object provided' do
      allow(EndpointBenchmark::Https.make_from_args(host: fqdn_valid_host1,
                                                    type: invalid_protocol2,
                                                    logger: logger)).to receive(
                                                      :head_request).
                                                    and_raise(StandardError)
    end
  end
end
