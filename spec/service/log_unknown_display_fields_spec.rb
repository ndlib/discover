require 'spec_helper'

describe LogUnknownDisplayFields do
  let(:display_fields) { {title: 'Test Title', creator: 'John Doe'} }
  let(:discovery_record) { double(DiscoveryRecord, display_fields: display_fields) }
  let(:field_class) { PrimoDisplayField }

  describe 'self' do
    subject { described_class }

    describe '#call' do
      it 'calls #log on an instance' do
        expect_any_instance_of(subject).to receive(:log)
        subject.call(discovery_record)
      end
    end

    describe '#known_fields' do
      it 'is an array' do
        expect(subject.known_fields).to be_a_kind_of(Array)
      end
    end
  end

  describe 'instance' do
    subject { described_class.new(discovery_record) }

    describe '#unknown_fields' do
      it 'returns an empty array when all fields are known' do
        expect(described_class).to receive(:known_fields).and_return(display_fields.keys)
        expect(subject.unknown_fields).to eq([])
      end
      it 'returns an array with any unknown field names' do
        expect(described_class).to receive(:known_fields).and_return([:title])
        expect(subject.unknown_fields).to eq([:creator])
      end
    end

    describe '#log_field' do
      let(:key) { 'title' }

      it 'creates a record' do
        expect{subject.log_field(key)}.to change{field_class.count}.by(1)
      end

      it 'returns an existing record' do
        record = field_class.create(key: key)
        expect{subject.log_field(key)}.to change{field_class.count}.by(0)
        expect(subject.log_field(key)).to eq(record)
      end

      it 'calls #add_example on a record'
    end

    describe '#log' do
      it 'logs things'
    end
  end
end
