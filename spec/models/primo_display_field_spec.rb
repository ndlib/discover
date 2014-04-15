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
end
