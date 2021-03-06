require 'spec_helper'

describe DiscoveryRecord do
  let(:test_search) { "ndu_aleph000188916" }
  let(:json) { JSON.parse(File.read(Rails.root.join('spec','fixtures','json_response.json'))) }

  subject { DiscoveryRecord.new(json) }

  describe '#log_unknown_display_fields' do
    it 'is called on initialize' do
      expect_any_instance_of(described_class).to receive(:log_unknown_display_fields)
      subject
    end

    it 'calls LogUnknownDisplayFields#call' do
      expect(LogUnknownDisplayFields).to receive(:call).with(subject)
      subject.log_unknown_display_fields
    end
  end

  describe :display_fields do
    it "is a hash" do
      expect(subject.display_fields).to be_a_kind_of(Hash)
    end

    it "display_fields returns the fields from the original primo record" do
      subject.stub(:primo).with('display').and_return( { 'primo_display' => 'true '} )
      expect(subject.display_fields).to eq({ 'primo_display' => 'true '})
    end
  end

  describe 'root attributes' do
    [:id, :type].each do |key|
      it "returns the #{key}" do
        expect(subject.send(key)).to eq(key.to_s)
      end
    end
  end

  describe :identifiers do
    [:isbn, :issn, :eissn, :doi, :pmid, :lccn, :oclc, :record_ids].each do | key |
      it "returns the #{key}" do
        expect(subject.send(key)).to eq([key.to_s])
      end
    end
  end


  describe :display_attributes do
    # standar attributes
    [:title, :vernacular_title, :language, :language_note, :general_notes, :rights, :source, :description, :contents, :edition, :publisher, :creation_date, :format, :coverage, :is_part_of, :biographical_note, :citation, :is_part_of, :earlier_title, :later_title, :supplement, :supplement_to, :issued_with, :parallel_title, :variant_title].each do | key |
      it "returns the #{key}" do
        expect(subject.send(key)).to eq([key.to_s])
      end
    end

    #complex attributes
    [:creator, :contributor, :subjects, :series, :uniform_titles].each do | key |
      it "returns the #{key}" do
        expect(subject.send(key)).to eq( { 'fulltext' => [key.to_s], 'hierarchical' => [ [key.to_s, key.to_s] ] } )
      end
    end
  end

  describe :identifiers do

    it "has identifiers" do
      expect(subject.identifiers).to eq({:isbn=>["isbn"], :issn=>["issn"], :eissn=>["eissn"], :doi=>["doi"], :pmid=>["pmid"], :lccn=>["lccn"], :oclc=>["oclc"]})
    end

    it "removes keys if they are blank" do
      subject.stub(:oclc).and_return("")
      expect(subject.identifiers).to eq({:isbn=>["isbn"], :issn=>["issn"], :eissn=>["eissn"], :doi=>["doi"], :pmid=>["pmid"], :lccn=>["lccn"]})
    end
  end


  describe :published do
    it "has published" do
      expect(subject.published).to eq(["publisher", "creation_date"])
    end

    it "excludes fields that are not in use" do
      subject.stub('creation_date').and_return(nil)
      expect(subject.published).to eq(["publisher"])
    end
  end


  describe :holdings do

    it "has holding infromation  " do
      expect(subject.holdings).to eq([{"record_id"=>"ndu_aleph000555617", "institution_code"=>"NDU", "collection_name"=>"General Collection", "collection_code"=>"GEN", "call_number"=>"(BR 1 .A4 )", "number_of_items"=>"0", "multi_volume"=>"Y"}])
    end

  end

  describe '#links' do
    it 'is a hash of institutional links' do
      expect(subject.links).to eq({"ndu"=>{"id"=>"ndu", "fulltext"=>[], "findtext"=>"", "ill"=>{}, "report_a_problem"=>{}}, "smc"=>{"id"=>"smc", "fulltext"=>[], "findtext"=>"", "ill"=>{}, "report_a_problem"=>{}}, "hcc"=>{"id"=>"hcc", "fulltext"=>[], "findtext"=>"", "ill"=>{}, "report_a_problem"=>{}}, "bci"=>{"id"=>"bci", "fulltext"=>[], "findtext"=>"", "ill"=>{}, "report_a_problem"=>{}}})
    end
  end
end
