require 'spec_helper'

describe DiscoveryRecord do
  let(:test_search) { "ndu_aleph000188916" }

  subject {
    VCR.use_cassette 'discovery/attributes_single_id_response' do
      DiscoveryQuery.new.find_by_id(test_search)
    end
  }

  describe "attributes" do

    before(:each) do
      VCR.use_cassette 'discovery/attributes_single_id_response' do
        @discovery_record = DiscoveryQuery.new.find_by_id(test_search)
      end
    end

    it "has a type" do
      expect(subject.type).to eq('book')
    end


    it "has a title" do
      subject.title.should == "The once and future king."
    end


    it "has the creator_contributor" do
      subject.creator_contributor.should == "T. H. White [Terence Hanbury], 1906-1964."
    end


    it "has details" do
      subject.details.should == ""
    end



    it "has publisher_provider" do
      subject.publisher_provider.should == "New York, Putnam 1958"
    end


    it "has availability" do
      subject.availability.should == "Available"
    end


    it "has availabile_library" do
      subject.available_library.should == "Notre Dame, Hesburgh Library General Collection (PR 6045 .H676 O5 )"
    end
  end

end
