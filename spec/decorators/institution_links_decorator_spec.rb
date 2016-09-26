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
      "finding_aids" => [
        {
          "url" => "http://rbsc.library.nd.edu/finding_aid/RBSC-MSNEA0506:143",
          "title" => "Full description / Finding Aid",
          "notes" => [ ],
          "service_type" => "Finding Aid",
          "source" => "Primo"
        },
      ],
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

  describe '#display_content?' do
    it 'is false when has_fulltext_links? is false' do
      expect(subject).to receive(:has_fulltext_links?).and_return(false)
      expect(subject.display_content?).to be_false
    end

    it 'is true when has_fulltext_links? is true' do
      expect(subject).to receive(:has_fulltext_links?).and_return(true)
      expect(subject.display_content?).to be_true
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

  describe '#finding_aid_links' do
    it 'is the finding aid links' do
      expect(subject.finding_aid_links).to eq(["<a href=\"http://rbsc.library.nd.edu/finding_aid/RBSC-MSNEA0506:143\" target=\"_blank\">Full description / Finding Aid</a>"])
    end
  end

  describe '#display_report_a_problem?' do
    it 'is false' do
      expect(subject.display_report_a_problem?).to be_false
    end
  end

  describe 'ill' do
    describe 'no content' do
      before do
        allow(subject).to receive(:get).with(:ill).and_return(nil)
      end

      it '#display_ill_link? is false' do
        expect(subject.display_ill_link?).to be_false
      end
    end

    describe 'with ill link' do
      let(:ill_content) {
        {
          "url" => "https://nd.illiad.oclc.org/illiad/IND/illiad.dll/OpenURL?rft.issn=0300-8495&rft.volume=43&rft.month=5&rft.genre=article&rft.auinit=D&rft.pub=Australian+College+of+General+Practitioners.&rft.stitle=AUST+FAM+PHYSICIAN&rft.issue=5&rft.place=Sydney%2C&rft.title=Australian+family+physician&rft.aufirst=David&linktype=openurl&rft.atitle=Anticoagulation%3A+a+GP+primer+on+the+new+oral+anticoagulants&rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3A&rft.auinit1=D&rft.date=2014&rft.aulast=Brieger&rft.epage=259&rft.spage=254",
          "title" => "Interlibrary Loan",
          "notes" => [ ],
          "service_type" => "getDocumentDelivery",
          "source" => "SFX"
        }
      }

      before do
        allow(subject).to receive(:get).with(:ill).and_return(ill_content)
      end

      it '#display_ill_link? is true if fulltext links are not present' do
        expect(subject).to receive(:fulltext).and_return([])
        expect(subject.display_ill_link?).to be_true
      end

      it '#display_ill_link? is false if fulltext links are present' do
        expect(subject).to receive(:fulltext).and_return([1])
        expect(subject.display_ill_link?).to be_false
      end
    end
  end

end
