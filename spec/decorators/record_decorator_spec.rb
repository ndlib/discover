require 'spec_helper'

describe RecordDecorator do
  subject { described_class.new(nil) }

  describe '#detail_content' do
    before do
      subject.stub(:detail_methods).and_return([:title, :author])
    end

    it 'returns an array of arrays' do
      subject.stub(:title).and_return('Test Title')
      subject.stub(:author).and_return('John Doe')

      expect(subject.detail_content).to be == [[:title, 'Test Title'],[:author, 'John Doe']]
    end

    it 'only returns values for methods with content' do
      subject.stub(:title).and_return('Test Title')
      subject.stub(:author).and_return(nil)

      expect(subject.detail_content).to be == [[:title, 'Test Title']]
    end
  end

  describe '#detail_methods' do
    it 'responds to each method' do
      subject.detail_methods.each do |method,label|
        expect(subject).to respond_to(method)
      end
    end
  end

  describe 'found record' do
    let(:object) { double(DiscoveryRecord) }

    subject do
      RecordDecorator.new(object)
    end

    describe '#display_fields' do
      it 'is the object display_fields' do
        expect(object).to receive(:display_fields)
        subject.display_fields
      end
    end

    describe '#title' do
      it 'is the object title' do
        expect(object).to receive(:title)
        subject.title
      end
    end

    describe '#author' do
      before(:each) do
        object.stub(:creator).and_return(['creator'])
      end

      it 'is the object author' do
        expect(object).to receive(:creator)
        subject.author
      end

      it "creates heirarctical links out of the author" do
        expect(HierarchicalSearchLinks).to receive(:render)
        subject.author
      end

      it "returns a ul with lis" do
        HierarchicalSearchLinks.stub(:render).with("creator", :creator).and_return("creator1_link")

        expect(subject.author).to eq("<ul><li>creator1_link</li></ul>")
      end
    end


    describe "#contributor" do
      before(:each) do
        object.stub(:contributor).and_return(['contributors1', 'contributors2'])
      end

      it 'is the object author' do
        expect(object).to receive(:contributor)
        subject.contributor
      end

      it "creates heirarctical links out of the contributors" do
        expect(HierarchicalSearchLinks).to receive(:render).twice
        subject.contributor
      end

      it "returns a ul with lis" do
        HierarchicalSearchLinks.stub(:render).with("contributors1", :creator).and_return("contributors1_link")
        HierarchicalSearchLinks.stub(:render).with("contributors2", :creator).and_return("contributors2_link")

        expect(subject.contributor).to eq("<ul><li>contributors1_link</li><li>contributors2_link</li></ul>")
      end

    end

    describe '#published' do
      before(:each) do
        object.stub(:published).and_return(['edition', 'publisher', 'creationdate', 'format'])
      end

      it 'is the object publisher_provider' do
        expect(object).to receive(:published)
        subject.published
      end

      it "returns an array" do
        expect(subject.published).to eq("<ul><li>edition</li><li>publisher</li><li>creationdate</li><li>format</li></ul>")
      end
    end

    describe '#description' do
      it 'is the object#description' do
        expect(object).to receive(:description)
        subject.description
      end
    end

    describe '#general_notes' do
      before(:each) do
        object.stub(:general_notes).and_return(['general_notes', 'general_notes2'])
      end

      it 'is the subject#general_notes' do
        expect(object).to receive(:general_notes)
        subject.general_notes
      end

      it "returns a ul with lis" do
        expect(subject.general_notes).to eq("<ul><li>general_notes</li><li>general_notes2</li></ul>")
      end
    end

    describe '#subjects' do
      before(:each) do
        object.stub(:subjects).and_return(['subject1 -- subsubject', 'subject2_no_subsubject'])
      end

      it 'is the object#subjects' do
        expect(object).to receive(:subjects)
        subject.subjects
      end

      it "creates heirarctical links out of the subjects" do
        expect(HierarchicalSearchLinks).to receive(:render).twice
        subject.subjects
      end

      it "returns a ul with lis" do
        HierarchicalSearchLinks.stub(:render).with("subject1 -- subsubject", :subject).and_return("sub1_link")
        HierarchicalSearchLinks.stub(:render).with("subject2_no_subsubject", :subject).and_return("sub2_link")

        expect(subject.subjects).to eq("<ul><li>sub1_link</li><li>sub2_link</li></ul>")
      end
    end


    describe "#contents" do
      before(:each) do
        object.stub(:contents).and_return(['contents1', 'contents2', 'contents3'])
      end

      it "is the object#contents" do
        expect(object).to receive(:contents)
        subject.contents
      end

      it "returns an array" do
        expect(subject.contents).to eq("<ul><li>contents1</li><li>contents2</li><li>contents3</li></ul>")
      end
    end

    describe "#series" do
      before(:each) do
        object.stub(:series).and_return(['series1', 'series2'])
      end

      it "is the object#contents" do
        expect(object).to receive(:series)
        subject.series
      end

      it "creates heirarctical links out of the series" do
        expect(HierarchicalSearchLinks).to receive(:render).twice
        subject.series
      end

      it "returns an array" do
        HierarchicalSearchLinks.stub(:render).with("series1", :series).and_return("series1_link")
        HierarchicalSearchLinks.stub(:render).with("series2", :series).and_return("series2_link")

        expect(subject.series).to eq("<ul><li>series1_link</li><li>series2_link</li></ul>")
      end
    end

    describe '#language' do
      it 'is the object#language' do
        expect(object).to receive(:language)
        subject.language
      end
    end

    describe '#identifier' do
      before(:each) do
        object.stub(:identifier).and_return(['identifier1', 'identifier2'])
      end

      it 'is the #identifier' do
        expect(object).to receive(:identifier)
        subject.identifier
      end

     it "returns an ul" do
        expect(subject.identifier).to eq("<ul><li>identifier1</li><li>identifier2</li></ul>")
      end
    end

    describe '#type' do
      it 'is the object type' do
        expect(object).to receive(:type)
        subject.type
      end
    end


    describe '#type' do
      it 'is the object source' do
        expect(object).to receive(:source)
        subject.source
      end
    end

    describe '#uniform_titles' do
      before(:each) do
        object.stub(:uniform_titles).and_return(['uniform_titles1', 'uniform_titles2'])
      end

      it 'is the object publisher_provider' do
        expect(object).to receive(:uniform_titles)
        subject.uniform_titles
      end

      it "creates heirarctical links out of the series" do
        expect(HierarchicalSearchLinks).to receive(:render).twice
        subject.uniform_titles
      end

      it "returns an array" do
        HierarchicalSearchLinks.stub(:render).with("uniform_titles1", :uniform_title).and_return("title1_link")
        HierarchicalSearchLinks.stub(:render).with("uniform_titles2", :uniform_title).and_return("title2_link")

        expect(subject.uniform_titles).to eq("<ul><li>title1_link</li><li>title2_link</li></ul>")
      end
    end

    describe '#record_ids' do
      before(:each) do
        object.stub(:record_ids).and_return(['record_id1', 'record_id2'])
      end

      it 'is the #record_ids' do
        expect(object).to receive(:record_ids)
        subject.record_ids
      end

      it "returns an ul with the records id" do
        expect(subject.record_ids).to eq("<ul><li>record_id1</li><li>record_id2</li></ul>")
      end
    end

    describe '#oclc' do
      it 'is the object oclc' do
        expect(object).to receive(:oclc).and_return("12345")
        expect(subject.oclc).to eq("12345")
      end

      it 'removes any leading zeros' do
        expect(object).to receive(:oclc).and_return("0023456")
        expect(subject.oclc).to eq("23456")
      end
    end

    describe '#isbn' do
      it 'is the object isbn' do
        expect(object).to receive(:isbn).and_return("12345")
        expect(subject.isbn).to eq("12345")
      end
    end

    describe '#issn' do
      it 'is the object issn' do
        expect(object).to receive(:issn).and_return("12345")
        expect(subject.issn).to eq("12345")
      end
    end

    describe '#worldcat_identifiers' do
      let(:identifiers) { { oclc: '12345', isbn: '23456', issn: '34567'} }
      it 'returns the oclc, isbn, and issn' do
        identifiers.keys.each do |method|
          expect(object).to receive(method).and_return(identifiers[method])
        end
        expect(subject.worldcat_identifiers).to eq(identifiers.to_a)
      end
    end

    describe '#worldcat_identifier' do
      let(:identifiers) { [[:oclc, "12345"], [:isbn, "23456"], [:issn, "34567"]] }
      it 'returns the first worldcat_identifier' do
        expect(subject).to receive(:worldcat_identifiers).and_return(identifiers)
        first = identifiers.first
        expect(identifiers).to receive(:first).and_return(first)
        expect(subject.worldcat_identifier).to eq(first)
      end
    end

    describe '#worldcat_identifier' do
      it 'return a url to worldcat for the identifier' do
        expect(subject).to receive(:worldcat_identifier).and_return([:oclc, "12345"])
        expect(subject.worldcat_url).to eq("http://www.worldcat.org/oclc/12345")
      end

      it 'is nil if there is no identifier' do
        expect(subject).to receive(:worldcat_identifier).and_return(nil)
        expect(subject.worldcat_url).to be_nil
      end
    end
  end
end
