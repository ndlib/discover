require 'spec_helper'

describe RecordIdLinkHathi do
  let(:record_id) { 'hathi_pubMIU01-004528545' }
  subject { described_class.new(record_id) }

  describe '#record_id' do
    it 'is the pc record id' do
      expect(subject.record_id).to eq("004528545")
    end
  end

  describe '#institution_name' do
    it 'is Notre Dame' do
      expect(subject.institution_name).to eq('Hathi Trust')
    end
  end

  describe '#render' do
    it 'is the labeled record id' do
      expect(subject.render).to eq("Hathi Trust: 004528545")
    end
  end
end
