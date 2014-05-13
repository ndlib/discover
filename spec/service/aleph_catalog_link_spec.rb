require 'spec_helper'

describe AlephCatalogLink do
  let(:record_id) { "ndu_aleph001890313" }
  let(:system_number) { record_id.gsub(/[^\d]+/,'')}
  subject { described_class.new(record_id) }

  describe '#system_number' do
    it 'is the numeric system number' do
      expect(subject.system_number).to eq(system_number)
    end
  end

  describe '#direct_path' do
    it 'is the direct link path' do
      expect(subject.direct_path).to eq("/F/?func=direct&doc_number=#{system_number}&local_base=ndu01pub")
    end
  end

  describe '#search_path' do
    it 'is the search path on aleph' do
      expect(subject.search_path).to eq("/F/?func=scan&scan_code=SYS&scan_start=#{system_number}&local_base=ndu01pub")
    end
  end

  describe '#institution_code' do
    it 'is ndu' do
      expect(subject.institution_code).to eq('ndu')
    end
  end

  describe '#local_base' do
    it 'is ndu01pub' do
      expect(subject.local_base).to eq('ndu01pub')
    end
  end
end
