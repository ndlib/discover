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

    describe :creator do
      it "has the creator" do
        expect(subject.creator).to eq(["creator"])
      end

      it "handels format being an array " do
        subject.stub(:display_field).with(:creator).and_return(['creator1', 'creator2'])
        expect(subject.creator).to eq(["creator1", "creator2"])
      end
    end

    it "has a contributor" do
      expect(subject.contributor).to eq(["contributor"])
    end

    describe "language" do
      it "has language" do
        expect(subject.language).to eq("English")
      end

      it "uses the language list to look up the name from the iso code" do
        expect(LanguageList::LanguageInfo).to receive(:find).with('eng')
        subject.language
      end
    end

    it "has a source" do
      expect(subject.source).to eq("source")
    end

    describe "#publsihed"  do
      it "has published" do
        expect(subject.published).to eq(["edition", "publisher", "creation_date", "format"])
      end

      it "handels format being an array " do
        subject.stub(:display_field).and_return('default')
        subject.stub(:display_field).with(:format).and_return(['format1', 'format2'])
        expect(subject.published).to eq(["default", "default", "default", "format1", "format2"])
      end
    end

    describe "#uniform_titles"  do
      it "has uniform_titles" do
        expect(subject.uniform_titles).to eq(["uniform_titles1", "uniform_titles2"])
      end

      it "handels format being an array " do
        subject.stub(:display_field).with(:lds31).and_return('uniform_titles')
        expect(subject.uniform_titles).to eq(["uniform_titles"])
      end
    end


    describe "#series" do
      it "has a series" do
        expect(subject.series).to eq(["series1", 'series2'])
      end

      it "returns empty array if there is no content" do
        subject.stub(:display_field).with(:lds30).and_return(nil)
        expect(subject.series).to eq([])
      end

      it "returns an array when there is only 1 record" do
        subject.stub(:display_field).with(:lds30).and_return("1series")
        expect(subject.series).to eq(["1series"])
      end
    end

    describe :identifier do

      it "has identifier" do
        expect(subject.identifier).to eq([{"key"=>"value"}])
      end

      it "parsers multiple key value pairs into multiple results" do
        subject.stub(:display_field).with(:identifier).and_return("$$Ckey $$Vvalue; $$Ckey1 $$Vvalue1")
        expect(subject.identifier).to eq([{"key"=>"value"}, {"key1"=>"value1"}])
      end

      it "passes the text back if it is not in the $$ format " do
        subject.stub(:display_field).with(:identifier).and_return("text")
        expect(subject.identifier).to eq(["text"])
      end

      it "passes back nil empty when nil" do
        subject.stub(:display_field).with(:identifier).and_return(nil)
        expect(subject.identifier).to eq("")
      end
    end

    describe :record_ids do

      it "has all the record_ids" do
        expect(subject.record_ids).to eq(["recordid1", "recordid2"])
      end

      it "returns an array when there is only 1 record1" do
        subject.stub(:display_field).with(:lds02).and_return("1record_id")
        expect(subject.record_ids).to eq(["1record_id"])
      end

      it "returns empty array if there is no content" do
        subject.stub(:display_field).with(:lds02).and_return(nil)
        expect(subject.record_ids).to eq([])
      end
    end

    it "has the description" do
      expect(subject.description).to eq("description")
    end

    describe :general_notes do
      it "has the general_notes" do
        expect(subject.general_notes).to eq(["general_notes", "general_notes2"])
      end

      it "returns an array when there is only 1 record" do
        subject.stub(:display_field).with(:lds01).and_return("1general_notes")
        expect(subject.general_notes).to eq(["1general_notes"])
      end

      it "returns empty array if there is no content" do
        subject.stub(:display_field).with(:lds01).and_return(nil)
        expect(subject.general_notes).to eq([])
      end
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

      it "returns empty array if there is no content" do
        subject.stub(:display_field).with(:subject).and_return(nil)
        expect(subject.subjects).to eq([])
      end
    end
  end


  describe "#contents" do

    it "has contents" do
      expect(subject.contents).to eq(['contents1'])
    end

    it "splits the contents on the -- delimiter" do
      subject.stub(:display_field).with(:lds03).and_return("contents1-1--contents1-2")
      expect(subject.contents).to eq(["contents1-1", "contents1-2"])
    end

    it "strips out extra spaces around the content pieces" do
      subject.stub(:display_field).with(:lds03).and_return(" contents 1-1 -- contents 1-2 ")
      expect(subject.contents).to eq(["contents 1-1", "contents 1-2"])
    end

    it "returns empty array if there is no content" do
      subject.stub(:display_field).with(:lds03).and_return(nil)
      expect(subject.contents).to eq([])
    end
  end




  describe '#display_fields' do
    it "is a hash" do
      expect(subject.display_fields).to be_a_kind_of(Hash)
      expect(subject.display_fields['title']).to be == "title"
    end
  end

end
