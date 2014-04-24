require 'spec_helper'

describe RecordDecorator do
  subject { described_class.new(nil) }

  describe '#detail_content' do
    before do
      subject.stub(:detail_methods).and_return({title: 'Title', author: 'Author'})
    end

    it 'returns an array of arrays' do
      subject.stub(:title).and_return('Test Title')
      subject.stub(:author).and_return('John Doe')

      expect(subject.detail_content).to be == [['Title', 'Test Title'],['Author', 'John Doe']]
    end

    it 'only returns values for methods with content' do
      subject.stub(:title).and_return('Test Title')
      subject.stub(:author).and_return(nil)

      expect(subject.detail_content).to be == [['Title', 'Test Title']]
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
      it 'is the subject#general_notes' do
        expect(object).to receive(:general_notes)
        subject.general_notes
      end
    end

    describe '#subjects' do
      it 'is the object#subjects' do
        expect(object).to receive(:subjects)
        subject.subjects
      end
    end

    describe '#language' do
      it 'is the object#language' do
        expect(object).to receive(:language)
        subject.language
      end
    end

    describe '#identifier' do
      it 'is the #identifier' do
        expect(object).to receive(:identifier)
        subject.identifier
      end
    end

    describe '#type' do
      it 'is the object type' do
        expect(object).to receive(:type)
        subject.type
      end
    end

    describe '#record_id' do
      it 'is the #record_id' do
        expect(object).to receive(:record_ids)
        subject.record_ids
      end
    end
  end
end
