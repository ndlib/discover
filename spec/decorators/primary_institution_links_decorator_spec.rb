require 'spec_helper'

describe PrimaryInstitutionLinksDecorator do
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

    it 'is true when the targets are not loaded' do
      expect(subject.sfx_link_decorator).to receive(:targets_loaded?).and_return(false)
      expect(subject.display_sfx_link?).to be_true
    end

    it 'is true when the targets are not loaded and targets were found' do
      expect(subject.sfx_link_decorator).to receive(:targets_loaded?).and_return(true)
      expect(subject.sfx_link_decorator).to receive(:number_of_targets).and_return(1)
      expect(subject.display_sfx_link?).to be_true
    end

    it 'is false when the targets are not loaded and no targets were found' do
      expect(subject.sfx_link_decorator).to receive(:targets_loaded?).and_return(true)
      expect(subject.sfx_link_decorator).to receive(:number_of_targets).and_return(0)
      expect(subject.display_sfx_link?).to be_false
    end
  end

end
