require 'spec_helper'

describe AlephCatalogLink do
  let(:record_id) { "ndu_aleph001890313" }
  subject { described_class.new(record_id) }

  describe '#system_number' do
    it 'is the numeric system number' do
      expect(subject.system_number).to eq("001890313")
    end
  end

  describe '#direct_path' do
    it 'is the direct link path' do
      expect(subject.direct_path).to eq("/F/?func=direct&doc_number=001890313")
    end
  end

  describe '#search_path' do
    it 'is the search path on aleph' do
      expect(subject.search_path).to eq("/F/?func=scan&scan_code=SYS&scan_start=001890313")
    end
  end
end
