require 'spec_helper'

describe PrimoDisplayField do
  describe '#key' do
    it 'is required' do
      expect(subject).to have(1).error_on(:key)
      subject.key = 'test'
      expect(subject).to have(0).errors_on(:key)
    end

    it 'is unique' do
      described_class.create(key: 'test')
      subject.key = 'test'
      expect(subject).to have(1).error_on(:key)
      subject.key = 'test2'
      expect(subject).to have(0).errors_on(:key)
    end
  end

  describe 'self' do
    subject { described_class }

    describe '#log_unknown' do
      it 'creates a record' do
        expect{subject.log_unknown('test')}.to change{subject.count}.by(1)
      end

      it 'returns an existing record' do
        record = subject.create(key: 'test')
        expect{subject.log_unknown('test')}.to change{subject.count}.by(0)
        expect(subject.log_unknown('test')).to eq(record)
      end
    end
  end
end
