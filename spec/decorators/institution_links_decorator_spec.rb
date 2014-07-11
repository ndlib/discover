require 'spec_helper'

describe InstitutionLinksDecorator do
  let(:data) do
    {
      "id" =>"ndu",
      "fulltext" =>[ ],
      "table_of_contents" =>[ ],
      "findtext" =>{
        "url" =>"http://findtext.library.nd.edu:8889/ndu_local?ctx_enc=info%3Aofi%2Fenc%3AUTF-8&ctx_tim=2014-07-11T09%3A55%3A48EDT&ctx_ver=Z39.88-2004&rft.coden=NWSCAL&rft.date=1971&rft.eissn=0262-4079&rft.genre=journal&rft.issn=0262-4079&rft.jtitle=New+scientist&rft.lccn=2010250720&rft.oclcnum=02378350&rft.pub=New+Science+Publications%5D&rft.stitle=New+scientist&sfx.ignore_date_threshold=1",
        "title" =>"FindText",
        "notes" =>[ ],
        "service_type" =>"SFX",
        "source" =>"findtext",
        "targets_loaded" =>false,
        "number_of_targets" =>0
      },
      "ill" =>nil,
      "report_a_problem" =>nil
    }
  end
  subject { described_class.new(data) }

  describe '#id' do
    it 'is the id value' do
      expect(subject.id).to eq('ndu')
    end
  end

  describe '#display_sfx_link?' do
    it 'is false when there is no sfx_link_decorator' do
      expect(subject).to receive(:sfx_link_decorator).and_return(nil)
      expect(subject.display_sfx_link?).to be_false
    end

    it 'is false when sfx_link_decorator is not from primo' do
      expect(subject.sfx_link_decorator).to receive(:from_primo?).and_return(false)
      expect(subject.display_sfx_link?).to be_false
    end

    it 'is true when sfx_link_decorator from primo' do
      expect(subject.sfx_link_decorator).to receive(:from_primo?).and_return(true)
      expect(subject.display_sfx_link?).to be_true
    end
  end

  describe '#sfx_link' do
    it 'is displayed when display_sfx_link? is true' do
      expect(subject).to receive(:display_sfx_link?).and_return(true)
      expect(subject.sfx_link_decorator).to receive(:link).and_return('link')
      expect(subject.sfx_link).to eq('link')
    end

    it 'is not displayed when display_sfx_link? is false' do
      expect(subject).to receive(:display_sfx_link?).and_return(false)
      expect(subject.sfx_link).to be_nil
    end
  end

end
