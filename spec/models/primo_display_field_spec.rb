require 'spec_helper'

describe PrimoDisplayField do
  let(:key) {'test_key'}

  describe '#key' do
    it 'is required' do
      expect(subject).to have(1).error_on(:key)
      subject.key = key
      expect(subject).to have(0).errors_on(:key)
    end

    it 'is unique' do
      described_class.create(key: key)
      subject.key = key
      expect(subject).to have(1).error_on(:key)
      subject.key = "another_#{key}"
      expect(subject).to have(0).errors_on(:key)
    end
  end

  describe 'saved' do
    let(:record_id) { 'ndu_aleph000188916' }
    let(:body) { 'Test Body' }
    subject { described_class.create(key: key) }

    describe '#add_example' do
      it 'adds an example' do
        expect{subject.add_example(record_id, body)}.to change{subject.examples.count}.by(1)
      end

      it 'returns an existing example' do
        example = subject.add_example(record_id, body)
        expect(example).to be_a_kind_of(PrimoDisplayFieldExample)
        expect(subject.add_example(record_id, body)).to eq(example)
      end
    end
  end

  describe 'self' do
    subject { described_class }

    describe '#log_unknown' do
      it 'creates a record' do
        expect{subject.log_unknown(key)}.to change{subject.count}.by(1)
      end

      it 'returns an existing record' do
        record = subject.create(key: key)
        expect{subject.log_unknown(key)}.to change{subject.count}.by(0)
        expect(subject.log_unknown(key)).to eq(record)
      end

      it 'receives a block' do
        expect_any_instance_of(subject).to receive(:block_test)
        record = subject.create(key: key)
        subject.log_unknown(key) do |display_field|
          display_field.block_test
          expect(record).to be == display_field
        end
      end
    end
  end
end
