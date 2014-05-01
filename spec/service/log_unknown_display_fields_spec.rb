require 'spec_helper'

describe LogUnknownDisplayFields do
  let(:display_fields) { {title: 'Test Title', creator: 'John Doe'} }
  let(:discovery_record) { double(DiscoveryRecord, display_fields: display_fields, id: 'test_id') }
  let(:field_class) { PrimoDisplayField }
  let(:key) { 'title' }

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

    describe '#display_fields' do
      it 'calls display_fields on the DiscoveryRecord' do
        expect(discovery_record).to receive(:display_fields)
        subject.display_fields
      end
    end

    describe '#log_field' do

      it 'creates a record' do
        expect{subject.log_field(key)}.to change{field_class.count}.by(1)
      end

      it 'returns an existing record' do
        record = field_class.create(key: key)
        expect{subject.log_field(key)}.to change{field_class.count}.by(0)
        expect(subject.log_field(key)).to eq(record)
      end

      it 'calls #add_example' do
        expect(subject).to receive(:add_example).with(kind_of(field_class))
        subject.log_field(key)
      end
    end

    describe '#add_example' do
      let(:display_field) { field_class.create(key: key) }

      it 'adds an example' do
        expect{subject.add_example(display_field)}.to change{display_field.examples.count}.by(1)
      end

      it 'returns an existing example' do
        example = subject.add_example(display_field)
        expect(example).to be_a_kind_of(PrimoDisplayFieldExample)
        expect(subject.add_example(display_field)).to eq(example)
      end
    end

    describe '#log' do
      it 'does not log anything if there are no unknown fields' do
        subject.stub(:unknown_fields).and_return([])
        expect(subject).to_not receive(:log_field)
        subject.log
      end

      it 'logs an unknown field' do
        subject.stub(:unknown_fields).and_return([:title])
        expect(subject).to receive(:log_field).with(:title)
        subject.log
      end

      it 'logs multiple unknown fields' do
        subject.stub(:unknown_fields).and_return([:title, :author])
        expect(subject).to receive(:log_field).with(:title)
        expect(subject).to receive(:log_field).with(:author)
        subject.log
      end
    end

    describe "notifications" do
      it 'does not email anything if there are no unknown fields' do
        subject.stub(:unknown_fields).and_return([])
        expect{ subject.log }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end

      it 'emails an unknown field' do
        subject.stub(:unknown_fields).and_return([:title])
        expect{subject.log}.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'emails multiple unknown fields' do
        subject.stub(:unknown_fields).and_return([:title, :author])
        expect{subject.log}.to change { ActionMailer::Base.deliveries.count }.by(2)
      end
    end
  end
end
