require 'spec_helper'

describe DiscoveryRecord do
  let(:test_search) { "ndu_aleph000188916" }

  describe "attributes" do

    before(:each) do
      VCR.use_cassette 'discovery/attributes_single_id_response' do
        @discovery_record = DiscoveryQuery.new.find_by_id(test_search)
      end
    end

    it "has a type" do
      expect(@discovery_record.type).to eq('book')
    end


    it "has a title" do
      @discovery_record.title.should == "The once and future king."
    end


    it "has the creator_contributor" do
      @discovery_record.creator_contributor.should == "T. H. White [Terence Hanbury], 1906-1964."
    end


    it "has details" do
      @discovery_record.details.should == ""
    end



    it "has publisher_provider" do
      @discovery_record.publisher_provider.should == "New York, Putnam 1958"
    end


    it "has availability" do
      @discovery_record.availability.should == "Available"
    end


    it "has availabile_library" do
      @discovery_record.available_library.should == "Notre Dame, Hesburgh Library General Collection (PR 6045 .H676 O5 )"
    end
  end

end
