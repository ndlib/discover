require 'spec_helper'

describe ExampleRecordCollection do
  let(:record) {
    { 'id' => 'ndu_aleph001890313', "title" => "The catcher in the rye", 'description' => 'Book with multiple identifiers, hierarchical subjects, and 5 frbr results.'}
  }
  let(:records) { [record] }
  subject { described_class.new('ndu') }

  describe '#records' do
    it 'decorates a collection' do
      expect(ExampleRecordDecorator).to receive(:decorate_collection).with(['record']).and_return(['decorated_record'])
      expect(subject).to receive(:yaml_records).and_return(['record'])
      expect(subject.records).to eq(['decorated_record'])
    end
  end

  describe '#yaml_records' do
    it 'adds the institution to each record' do
      expect(subject).to receive(:institution_yaml).and_return(records)
      modified_record = record.merge({'institution' => 'ndu'})
      expect(subject.yaml_records).to eq([modified_record])
    end
  end

  describe '#institution_yaml' do
    it 'calls load_yaml' do
      expect(subject).to receive(:load_yaml).and_return({'ndu' => records})
      expect(subject.institution_yaml).to eq(records)
    end
  end
end
