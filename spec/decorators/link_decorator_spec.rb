require 'spec_helper'

describe LinkDecorator do
  subject { LinkDecorator.new(object) }
  let(:object) { { 'title' => 'title', 'url' => 'url', 'notes' => ['notes'] } }

  describe :title do
    it "returns title " do
      expect(subject.title).to eq('title')
    end
  end

  describe :url do
    it "returns url " do
      expect(subject.url).to eq('url')
    end
  end

  describe :link do
    it "returns a link" do
      expect(subject.link).to eq("<a target=\"_blank\" href=\"url\">title</a>")
    end
  end

  describe :notes do
    it "returns notes" do
      expect(subject.notes).to eq("<ul><li>notes</li></ul>")
    end
  end

  describe '#get' do
    it "returns a value from the object" do
      expect(subject.send(:get, 'title')).to eq('title')
    end
  end

  describe '#from_primo?' do
    it "is true when the source is Primo" do
      expect(subject).to receive(:source).and_return('Primo')
      expect(subject.from_primo?).to be_true
    end

    it "is false when the source is not Primo" do
      expect(subject).to receive(:source).and_return('test')
      expect(subject.from_primo?).to be_false
    end
  end
end
