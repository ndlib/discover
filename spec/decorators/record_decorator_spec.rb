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
      it 'is the object author' do
        expect(object).to receive(:creator)
        subject.author
      end
    end

    describe '#related_titles' do
      it 'is the object related_titles' do
        expect(object).to receive(:related_titles)
        subject.related_titles
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

      it "returns a ul with lis" do
        expect(subject.subjects).to eq("<ul><li>subject1 -- subsubject</li><li>subject2_no_subsubject</li></ul>")
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

    describe "#contents" do
      before(:each) do
        object.stub(:series).and_return(['series1', 'series2'])
      end

      it "is the object#contents" do
        expect(object).to receive(:series)
        subject.series
      end

      it "returns an array" do
        expect(subject.series).to eq("<ul><li>series1</li><li>series2</li></ul>")
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

      it "returns an ul" do
        expect(subject.uniform_titles).to eq("<ul><li><ul class=\"ndl-heiractical-search\"><li class=\"ndl-heiractical-search-1\"><a href=\"http://primo-fe1.library.nd.edu:1701/primo_library/libweb/action/search.do?fn=search&amp;mode=Advanced&amp;tab=onesearch&amp;vid=NDU&amp;vl%2816833817UI0%29=lsr04&amp;vl%281UIStartWith0%29=exact&amp;vl%28freeText0%29=+uniform_titles1\">uniform_titles1</a></li></ul></li><li><ul class=\"ndl-heiractical-search\"><li class=\"ndl-heiractical-search-1\"><a href=\"http://primo-fe1.library.nd.edu:1701/primo_library/libweb/action/search.do?fn=search&amp;mode=Advanced&amp;tab=onesearch&amp;vid=NDU&amp;vl%2816833817UI0%29=lsr04&amp;vl%281UIStartWith0%29=exact&amp;vl%28freeText0%29=+uniform_titles2\">uniform_titles2</a></li></ul></li></ul>")
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
  end
end
