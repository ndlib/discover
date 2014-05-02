require 'spec_helper'

describe ExampleRecordDecorator do
  let(:record) {
    { 'id' => 'ndu_aleph001890313', 'description' => 'Book with mulitple Identifiers and 5 frbr results.'}
  }

  let(:records) { [record] }

  describe 'self' do
    subject { described_class }

    describe '#all' do
      it 'decorates a collection' do
        expect(subject).to receive(:decorate_collection)
        subject.all
      end
    end

    describe '#records' do
      it 'calls load_yaml' do
        expect(subject).to receive(:load_yaml).and_return({'records' => records})
        subject.records
      end
    end

    describe '#load_yaml' do
      it 'loads the example records yaml file' do
        yaml = subject.load_yaml
        expect(yaml).to have_key('records')
        expect(yaml['records']).to be_a_kind_of(Array)
        expect(yaml['records'].first).to eq(record)
      end
    end
  end

  describe 'instance' do
    subject { described_class.new(record) }

    describe '#object' do
      it 'is the record' do
        expect(subject.object).to eq(record)
      end
    end
  end
end
