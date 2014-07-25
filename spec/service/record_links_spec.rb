require 'spec_helper'

describe RecordLinks do
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

  let(:record) { double(DiscoveryRecord, links: links, institution_code: 'ndu') }
  let(:links) do
    {}.tap do |hash|
      hash['institutions'] = institution_links
      hash['table_of_contents'] = []
      hash['finding_aids'] = []
      hash['reviews'] = []
      hash['add_links'] = []
    end
  end
  let(:institution_links) do
    {}.tap do |hash|
      ['ndu','smc','bci','hcc'].each do |code|
        hash[code] = link_data(code)
      end
    end
  end

  subject { described_class.new(record) }

  describe '#institution_links_decorators' do
    it 'is an hash containing link decorators' do
      expect(subject.institution_links_decorators).to be_a_kind_of(Hash)
      expect(subject.institution_links_decorators[:primary]).to be_a_kind_of(InstitutionLinksDecorator)
      expect(subject.institution_links_decorators[:other]).to be_a_kind_of(Array)
      expect(subject.institution_links_decorators[:other].count).to eq(3)
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

  describe '#all_additional_links' do
    it 'calls additional_links' do
      [:table_of_contents, :finding_aids, :reviews, :add_links].each do |key|
        expect(subject).to receive(:additional_links).with(key).and_return(["#{key}"])
      end
      expect(subject.all_additional_links).to eq(["table_of_contents", "finding_aids", "reviews", "add_links"])
    end
  end

  describe '#additional_links' do
    let(:decorator) { double(LinkDecorator) }
    it 'collects the decorator links' do
      expect(subject).to receive(:additional_links_decorators).with('add_links').and_return([decorator])
      expect(decorator).to receive(:link).and_return('link')
      expect(subject.additional_links('add_links')).to eq(['link'])
    end
  end

  describe '#additional_links_decorators' do
    let(:decorator) { double(LinkDecorator) }
    it 'creates a decorator for each link hash' do
      expect(subject).to receive(:get).with('add_links').and_return(['link_hash'])
      expect(LinkDecorator).to receive(:new).with('link_hash').and_return(decorator)
      expect(subject.additional_links_decorators('add_links')).to eq([decorator])
    end
  end

end
