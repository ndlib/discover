require 'spec_helper'

describe ExampleRecordDecorator do
  let(:record) do
    { 'id' => 'ndu_aleph001890313', "title" => "The catcher in the rye", 'description' => 'Book with multiple identifiers, hierarchical subjects, and 5 frbr results.'}
  end

  let(:records) { [record] }

  subject { described_class.new(record) }

  describe '#object' do
    it 'is the record' do
      expect(subject.object).to eq(record)
    end
  end

  describe '#id' do
    it 'is the record id' do
      expect(subject.id).to eq(record['id'])
    end
  end

  describe '#title' do
    it 'is the record title' do
      expect(subject.title).to eq(record['title'])
    end
  end

  describe '#description' do
    it 'is the record description' do
      expect(subject.description).to eq(record['description'])
    end
  end

  describe '#record_link' do
    it 'links to the record locally' do
      expect(subject.record_link).to eq("<a target=\"_blank\" href=\"/record?id=ndu_aleph001890313\">Details</a>")
    end
  end

  describe '#online_access_link' do
    it 'links to the online_access locally' do
      expect(subject.online_access_link).to eq("<a target=\"_blank\" href=\"/online_access?id=ndu_aleph001890313\">Online Access</a>")
    end
  end

  describe '#json_link' do
    it 'links to json' do
      expect(subject.json_link).to eq("<a target=\"_blank\" href=\"/record.json?id=ndu_aleph001890313\">JSON</a>")
    end
  end

  describe '#primo_search_id' do
    it 'is the ndu_aleph id' do
      expect(subject.primo_search_id).to eq(subject.id)
    end

    it 'removes the TN_ prefix' do
      tn_id = 'TN_gale_ofa277204662'
      tn_removed = tn_id.gsub('TN_', '')
      expect(subject).to receive(:id).and_return(tn_id)
      expect(subject.primo_search_id).to eq(tn_removed)
    end
  end

  describe '#primo_link' do
    it 'links to primo' do
      expect(subject).to receive(:primo_search_id).and_return(subject.id)
      expect(subject.primo_link).to eq("<a target=\"_blank\" href=\"http://onesearchpprd.library.nd.edu/primo_library/libweb/action/search.do?fn=search&amp;mode=Basic&amp;tab=onesearch&amp;vid=NDU&amp;vl%28freeText0%29=ndu_aleph001890313\">Primo 4</a>")
    end
  end
end
