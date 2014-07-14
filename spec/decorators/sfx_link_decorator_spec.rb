require 'spec_helper'

describe SFXLinkDecorator do

  subject { described_class.new(object) }

  let(:object) {   { 'title' => 'title', 'url' => 'url', 'notes' => [ 'notes' ], 'targets_loaded' => false, 'number_of_targets' => 0 } }


  describe '#title' do
    it "It is search when targets haven't been loaded" do
      expect(subject.title).to eq('Search in FindText')
    end

    it "Is view when targets have been loaded" do
      subject.stub(:targets_loaded?).and_return(true)
      expect(subject.title).to eq('View in FindText')
    end
  end

  describe :link do
    it "returns a link" do
      expect(subject.link).to eq("<a href=\"url\" target=\"_blank\">Search in FindText</a>")
    end
  end


  describe '#targets_loaded?' do
    it "returns the object targets_loaded" do
      expect(subject).to receive(:get).with('targets_loaded').and_return(true)
      expect(subject.targets_loaded?).to be_true
    end
  end

  describe '#number_of_targets' do
    it "returns the object number_of_targets" do
      expect(subject).to receive(:get).with('number_of_targets').and_return(1)
      expect(subject.number_of_targets).to eq(1)
    end
  end


end
