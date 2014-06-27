require 'spec_helper'

describe DetailsTab do
  let(:params) { HashWithIndifferentAccess.new( vid: 'BCI', id: 'test', tab: 'onesearch') }
  let(:test_controller) { double(RecordsController, params: params) }
  let(:record) { double(DiscoveryRecord) }

  subject { described_class.new(test_controller) }

  describe '#vid' do
    it 'is the params vid' do
      expect(subject.vid).to eq('BCI')
    end
  end

  describe '#controller' do
    it 'is the object' do
      expect(subject.controller).to eq(test_controller)
    end
  end

  describe '#id' do
    it 'is the params id' do
      expect(subject.id).to eq('test')
    end
  end

  describe '#tab' do
    it 'is the params tab' do
      expect(subject.tab).to eq('onesearch')
    end
  end

  describe '#record' do
    it 'calls #load_record and caches the result' do
      expect(subject).to receive(:load_record).once.and_return(record)
      subject.record
      subject.record
    end
  end

  describe '#load_record' do
    it 'calls DiscoveryQuery' do
      expect(DiscoveryQuery).to receive(:find_by_id)
      subject.send(:load_record)
    end
  end

  describe 'stubbed record' do
    before do
      subject.stub(:record).and_return(record)
    end

    describe '#record_id' do
      it 'is the record id' do
        expect(record).to receive(:id).and_return('id')
        expect(subject.record_id).to eq('id')
      end
    end
  end

  describe '#primo_configuration' do
    it 'is a PrimoConfiguration' do
      expect(subject.primo_configuration).to be_a_kind_of(PrimoConfiguration)
    end

    it 'calls PrimoConfiguration.new' do
      expect(PrimoConfiguration).to receive(:new).with(subject.vid)
      subject.primo_configuration
    end
  end

  describe '#primo_uri' do
    it 'is a PrimoURI' do
      expect(subject.primo_uri).to be_a_kind_of(PrimoURI)
    end

    it 'calls PrimoURI.new' do
      expect(PrimoURI).to receive(:new).with(subject.primo_configuration, subject.tab)
      subject.primo_uri
    end
  end
end
