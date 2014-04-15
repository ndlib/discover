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
    let(:search_id) { "ndu_aleph000188916" }

    subject do
      VCR.use_cassette 'discovery_query/find_by_id' do
        described_class.find(search_id)
      end
    end

    let(:object) { subject.object }

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

    describe '#title' do
      it 'is the object title' do
        expect(subject.title).to be == object.title
      end
    end

    describe '#author' do
      it 'is the object author' do
        expect(subject.author).to be == object.creator_contributor
      end
    end

    describe '#published' do
      it 'is the object publisher_provider' do
        expect(subject.published).to be == object.publisher_provider
      end
    end

    describe '#description' do
      it 'is the #description'
    end

    describe '#general_notes' do
      it 'is the #general_notes'
    end

    describe '#subjects' do
      it 'is the #subjects'
    end

    describe '#language' do
      it 'is the #language'
    end

    describe '#identifier' do
      it 'is the #identifier'
    end

    describe '#type' do
      it 'is the #type'
    end

    describe '#record_id' do
      it 'is the #record_id'
    end
  end
end
