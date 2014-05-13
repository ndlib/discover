require 'spec_helper'

describe AlephCatalogLink do
  let(:record_id) { "ndu_aleph001890313" }
  let(:system_number) { record_id.gsub(/[^\d]+/,'')}
  subject { described_class.new(record_id) }

  describe '#aleph_record?' do
    it 'is true for records with _aleph' do
      expect(subject.aleph_record?).to be_true
    end

    it 'is false for records without _aleph' do
      expect(subject).to receive(:id).and_return('TN_12345')
      expect(subject.aleph_record?).to be_false
    end
  end

  describe '#system_number' do
    it 'is the numeric system number' do
      expect(subject.system_number).to eq(system_number)
    end
  end

  describe '#institution_code' do
    it 'is ndu' do
      expect(subject.institution_code).to eq('ndu')
    end
  end

  describe '#institution_name' do
    it 'is Notre Dame' do
      expect(subject.institution_name).to eq('Notre Dame')
    end
  end

  describe '#local_base' do
    it 'is ndu01pub' do
      expect(subject.local_base).to eq('ndu01pub')
    end
  end

  describe '#direct_path' do
    it 'is the direct link path' do
      expect(subject.direct_path).to eq("/F/?func=direct&doc_number=#{system_number}&local_base=ndu01pub")
    end
  end

  describe '#direct_url' do
    it 'is the direct url' do
      expect(subject.direct_url).to eq('https://alephprod.library.nd.edu/F/?func=direct&doc_number=001890313&local_base=ndu01pub')
    end
  end

  describe '#direct_link_title' do
    it 'is the title of the link' do
      expect(subject.direct_link_title).to eq("Notre Dame: #{system_number}")
    end
  end

  describe '#direct_link' do
    it 'is the link' do
      expect(subject.direct_link).to eq("<a href=\"https://alephprod.library.nd.edu/F/?func=direct&amp;doc_number=001890313&amp;local_base=ndu01pub\">Notre Dame: 001890313</a>")
    end

    it 'is the id if not an aleph record' do
      expect(subject).to receive(:aleph_record?).and_return(false)
      expect(subject.direct_link).to eq(record_id)
    end
  end
end
