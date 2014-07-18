require 'spec_helper'

describe SFXLinkDecorator do

  subject { described_class.new(object) }

  let(:findtext_url) { 'http://findtext.library.nd.edu:8889/ndu_local?ctx_enc=info%3Aofi%2Fenc%3AUTF-8&ctx_tim=2014-07-18T14%3A23%3A04EDT&ctx_ver=Z39.88-2004&rft.au=Salinger%2C+J.+D&rft.aufirst=J.+D.&rft.aulast=Salinger&rft.btitle=The+catcher+in+the+rye&rft.date=2001&rft.genre=book&rft.isbn=9780316769174&rft.lccn=00108915&rft.oclcnum=45798952&rft.pub=Little%2C+Brown' }

  let(:object) {
    {
      'title' => 'title',
      'url' => findtext_url,
      'notes' => [ 'notes' ],
      'targets_loaded' => false,
      'number_of_targets' => 0
    }
  }


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
      expect(subject.link).to eq("<a class=\"ndl-sfx\" href=\"#{findtext_url.gsub('&','&amp;')}\" target=\"_blank\"><span>Search in FindText</span><img alt=\"Sfx\" src=\"http://findtext.library.nd.edu:8889/ndu_local/sfx.gif\" /></a>")
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
