require 'spec_helper'

describe RecordIdLinkLaw do
  let(:record_id) { 'ndlaw_iii.b18599291' }
  subject { described_class.new(record_id) }

  describe '#record_id' do
    it 'is the pc record id' do
      expect(subject.record_id).to eq("b18599291")
    end
  end

  describe '#institution_name' do
    it 'is Notre Dame' do
      expect(subject.institution_name).to eq('Notre Dame Law School')
    end
  end

  describe '#render' do
    it 'is the labeled record id' do
      expect(subject.render).to eq("Notre Dame Law School: b18599291")
    end
  end
end
