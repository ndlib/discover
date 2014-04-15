require 'spec_helper'

describe RecordDecorator do
  let(:search_id) { "ndu_aleph000188916" }

  subject do
    VCR.use_cassette 'discovery_query/find_by_id' do
      described_class.find(search_id)
    end
  end

  describe '#object' do
    it 'is a DiscoveryRecord' do
      expect(subject.object).to be_a_kind_of(DiscoveryRecord)
    end
  end

  describe '#display_fields' do
    it 'is a hash' do
      expect(subject.display_fields).to be_a_kind_of(Hash)
    end
  end
end
