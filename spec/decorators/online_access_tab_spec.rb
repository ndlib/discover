require 'spec_helper'

describe OnlineAccessTab do
  def link_data(institution_code)
    {
      "id" => institution_code,
      "fulltext" =>[ ],
      "table_of_contents" =>[ ],
      "findtext" =>{
        "url" =>"http://findtext.library.nd.edu:8889/#{institution_code}_local?ctx_enc=info%3Aofi%2Fenc%3AUTF-8&ctx_tim=2014-07-11T09%3A55%3A48EDT&ctx_ver=Z39.88-2004&rft.coden=NWSCAL&rft.date=1971&rft.eissn=0262-4079&rft.genre=journal&rft.issn=0262-4079&rft.jtitle=New+scientist&rft.lccn=2010250720&rft.oclcnum=02378350&rft.pub=New+Science+Publications%5D&rft.stitle=New+scientist&sfx.ignore_date_threshold=1",
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

  let(:links) do
    {}.tap do |hash|
      hash['institutions'] = institution_links
    end
  end
  let(:institution_links) do
    {}.tap do |hash|
      ['ndu','smc','bci','hcc'].each do |code|
        hash[code] = link_data(code)
      end
    end
  end

  let(:test_controller) { double(RecordsController, params: {})}
  subject { described_class.new(test_controller) }

  describe 'found record' do
    let(:record) { double(DiscoveryRecord, links: links, institution_code: 'ndu') }

    before do
      subject.stub(:record).and_return(record)
    end

    describe '#record_links' do
      it 'is a RecordLinks' do
        expect(subject.record_links).to be_a_kind_of(RecordLinks)
        expect(subject.record_links.record).to eq(record)
      end
    end

    describe '#primary_institution_links' do
      it 'is the institution for the current vid' do
        expect(subject.primary_institution_links).to be_a_kind_of(InstitutionLinksDecorator)
        expect(subject.primary_institution_links.id).to eq('ndu')
      end
    end

    describe '#other_institutions_links' do
      it 'is the other institutions' do
        expect(subject.other_institutions_links).to be_a_kind_of(Array)
        expect(subject.other_institutions_links.count).to eq(3)
        subject.other_institutions_links.each do |instituion|
          expect(instituion).to be_a_kind_of(InstitutionLinksDecorator)
          expect(instituion.id).to_not eq('ndu')
        end
      end
    end

  end

end
