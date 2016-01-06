require 'spec_helper'

describe RecordIdLink::PrimoCentral do
  let(:record_id) { "TN_medline22021833" }
  let(:record) { double }
  subject { described_class.new(record_id) }

  describe '#record_id' do
    it 'is the pc record id' do
      expect(subject.record_id).to eq("medline22021833")
    end
  end

  describe '#institution_name' do
    it 'is Notre Dame' do
      expect(subject.institution_name).to eq('Primo Central')
    end
  end

  describe '#render' do
    it 'is the labeled record id' do
      expect(subject.render(record)).to eq("Primo Central: medline22021833")
    end
  end
end
