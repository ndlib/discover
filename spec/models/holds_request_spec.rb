require 'spec_helper'

describe HoldsRequest do
  subject { described_class.new({}) }

  describe :save_params do
    it "saves the request_id param" do
      subject.save_params(request_id: '1')
      expect(subject.request_id).to eq("1")
    end

    it "saves the pickup_location params" do
      subject.save_params(pickup_location: '1')
      expect(subject.pickup_location).to eq("1")
    end

    it "saves the cancel_date params" do
      subject.save_params(cancel_date: '1')
      expect(subject.cancel_date).to eq("1")
    end

    it "does not save extra keys" do
      subject.save_params(request_id: 1, other_key: '2')
      expect(subject.attributes).to eq(:request_id => "1", :pickup_location => nil, :cancel_date => nil)
    end
  end

  describe :initialize do
    it "allows you to pass in attributes" do
      o = described_class.new(request_id: '1', pickup_location: '2')
      expect(o.params).to eq(:request_id => "1", :pickup_location => "2", :cancel_date => nil)
    end
  end

  describe :params do
    it "returns all the values when they are set" do
      o = described_class.new(request_id: '1', pickup_location: '2', cancel_date: '10-10-1010')
      expect(o.params).to eq(:request_id => "1", :pickup_location => "2", :cancel_date => "10-10-1010")
    end
  end

  describe :complete? do
    it "returns true when they are all set" do
      o = described_class.new(request_id: '1', pickup_location: '2')
      expect(o.complete?).to be_true
    end

    it "returns false when they are not all set" do
      expect(subject.complete?).to be_false
    end
  end

  describe '#decrypted_item_id' do
    let(:item_id) { 'test' }
    let(:encrypted_item_id) { HoldItem.encrypt_item_id(item_id) }
    subject { described_class.new(request_id: encrypted_item_id) }

    it 'decrypts the request_id' do
      expect(subject.decrypted_item_id).to eq(item_id)
    end

    describe 'invalid request_id' do
      subject { described_class.new(request_id: 'fake') }

      it 'raises an error' do
        expect { subject.decrypted_item_id }.to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)
      end
    end
  end

  describe '#formatted_cancel_date' do
    it 'formats an ISO date string' do
      subject.cancel_date = '2014-01-01'
      expect(subject.formatted_cancel_date).to eq('20140101')
    end

    it 'does not modify a valid date string' do
      subject.cancel_date = '20140101'
      expect(subject.formatted_cancel_date).to eq('20140101')
    end

    it 'formats a US date string' do
      subject.cancel_date = '12/01/2014'
      expect(subject.formatted_cancel_date).to eq('20141201')
    end

    it 'returns nil' do
      subject.cancel_date = nil
      expect(subject.formatted_cancel_date).to be_nil
    end

    it 'returns nil for the null string' do
      subject.cancel_date = 'null'
      expect(subject.formatted_cancel_date).to be_nil
    end
  end

  describe '#hold_request_params' do
    it 'returns a hash' do
      subject.stub(:decrypted_item_id).and_return('decrypted_item_id')
      subject.stub(:pickup_location).and_return('pickup_location')
      subject.stub(:formatted_cancel_date).and_return('formatted_cancel_date')
      expect(subject.hold_request_params).to eq(:item_number => "decrypted_item_id", :pickup_location => "pickup_location", :cancel_date => "formatted_cancel_date")
    end
  end

  describe '#place_hold' do
    let(:item_number) { 'PRIMO$$$BCI01000136357$$$BCI50000136357000090' }
    let(:request_id) { HoldItem.encrypt_item_id(item_number) }
    subject { described_class.new(request_id: request_id, pickup_location: 'BCI') }
    describe 'valid request' do
      it 'succeeds' do
        VCR.use_cassette 'holds_request/ndu_aleph001526576' do
          response = subject.place_hold
          expect(response['status']).to eq('Success')
        end
      end
    end

    describe 'invalid request' do
      let(:item_number) { 'FAKE$$$FAKE$$$FAKE' }

      it 'fails' do
        VCR.use_cassette 'holds_request/fake' do
          response = subject.place_hold
          expect(response['status']).to eq('Failure')
        end
      end
    end
  end
end
