require 'spec_helper'

describe ExampleRecordDecorator do
  let(:record) {
    { 'id' => 'ndu_aleph001890313', "title" => "The catcher in the rye", 'description' => 'Book with mulitple Identifiers and 5 frbr results.'}
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

    describe '#id' do
      it 'is the record id' do
        expect(subject.id).to eq(record['id'])
      end
    end

    describe '#title' do
      it 'is the record title' do
        expect(subject.title).to eq(record['title'])
      end
    end

    describe '#description' do
      it 'is the record description' do
        expect(subject.description).to eq(record['description'])
      end
    end

    describe '#record_link' do
      it 'links to the record locally' do
        expect(subject.record_link).to eq("<a href=\"/record?id=#{record['id']}\" target=\"_blank\">Details</a>")
      end
    end

    describe '#json_link' do
      it 'links to json' do
        expect(subject.json_link).to eq("<a href=\"/record.json?id=#{record['id']}\" target=\"_blank\">JSON</a>")
      end
    end
  end
end
