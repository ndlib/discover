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
      subject.stub(:primo).and_return({ 'display' => { 'primo_display' => 'true '} })
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
    [:title, :language, :general_notes, :source, :description, :contents, :edition, :publisher, :creation_date, :format, :is_part_of].each do | key |
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
      expect(subject.published).to eq([["edition"], ["publisher"], ["creation_date"], ["format"]])
    end

    it "excludes fields that are not in use" do
      subject.stub('edition').and_return(nil)
      expect(subject.published).to eq([["publisher"], ["creation_date"], ["format"]])
    end
  end


end
