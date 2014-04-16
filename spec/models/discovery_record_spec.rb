require 'spec_helper'

describe DiscoveryRecord do
  let(:test_search) { "ndu_aleph000188916" }

  subject {
    VCR.use_cassette 'discovery/attributes_single_id_response' do
      DiscoveryQuery.new.find_by_id(test_search)
    end
  }

  describe '#log_unknown_display_fields' do
    it 'is called on initialize' do
      expect_any_instance_of(described_class).to receive(:log_unknown_display_fields)
      subject
    end

    it 'calls LogUnknownDisplayFields#call' do
      expect(LogUnknownDisplayFields).to receive(:call).with(subject)
      subject.log_unknown_display_fields
    end
  end

  describe "attributes" do
    it "has an id" do
      expect(subject.id).to eq('dedupmrg21374725')
    end

    it "has a type" do
      expect(subject.type).to eq('book')
    end


    it "has a title" do
      expect(subject.title).to eq("The once and future king.")
    end


    it "has the creator_contributor" do
      expect(subject.creator_contributor).to eq("T. H. White [Terence Hanbury], 1906-1964.")
    end


    it "has details" do
      expect(subject.details).to be_nil
    end


    it "has publisher_provider" do
      expect(subject.publisher_provider).to eq("New York, Putnam 1958")
    end


    it "has availability" do
      expect(subject.availability).to eq("Available")
    end


    it "has availabile_library" do
      expect(subject.available_library).to eq("Notre Dame, Hesburgh Library General Collection (PR 6045 .H676 O5 )")
    end
  end

  describe '#display_fields' do
    it "is a hash" do
      expect(subject.display_fields).to be_a_kind_of(Hash)
      expect(subject.display_fields['title']).to be == "The once and future king."
    end
  end

end
