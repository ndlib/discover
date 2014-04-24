require 'spec_helper'

describe DiscoveryRecord do
  let(:test_search) { "ndu_aleph000188916" }

  subject {
    json = JSON.parse(File.read(Rails.root.join('spec','fixtures','test_json_response.json')))['records'].first
    DiscoveryRecord.new(json)
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

  describe :display_fields do
    it "is a hash" do
      expect(subject.display_fields).to be_a_kind_of(Hash)
    end
  end

  describe "attributes" do
    it "has an id" do
      expect(subject.id).to eq('id')
    end

    it "has a type" do
      expect(subject.type).to eq('book')
    end

    it "has a title" do
      expect(subject.title).to eq("title")
    end

    it "has the creator" do
      expect(subject.creator).to eq("creator")
    end

    it "has language" do
      expect(subject.language).to eq("lang")
    end


    it "has published" do
      expect(subject.published).to eq(["edition", "publisher", "creation_date", "format"])
    end


    it "has identifier" do
      expect(subject.identifier).to eq("identifier")
    end

    describe :record_ids do

      it "has all the record_ids" do
        expect(subject.record_ids).to eq(["recordid1", "recordid2"])
      end

      it "returns an array when there is only 1 record1" do
        subject.stub(:display_field).with(:lds02).and_return("1record_id")
        expect(subject.record_ids).to eq(["1record_id"])
      end
    end

    it "has the description" do
      expect(subject.description).to eq("description")
    end

    it "has the general_notes" do
      expect(subject.general_notes).to eq("general_notes")
    end

    it "has availability" do
      expect(subject.availability).to eq("available")
    end

    describe :subjects do
      it "has subjects" do
        expect(subject.subjects).to eq(["subject1", "subject2", "subject3"])
      end

      it "returns an array when there is only 1 record1" do
        subject.stub(:display_field).with(:subject).and_return("1subject")
        expect(subject.subjects).to eq(["1subject"])
      end
    end

  end

  describe '#display_fields' do
    it "is a hash" do
      expect(subject.display_fields).to be_a_kind_of(Hash)
      expect(subject.display_fields['title']).to be == "title"
    end
  end

end
