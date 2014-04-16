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
end
