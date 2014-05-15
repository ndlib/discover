require 'spec_helper'

describe DiscoveryQuery do


  describe "class#find_by_id" do

    it "calls the instance method" do
      expect_any_instance_of(DiscoveryQuery).to receive(:find_by_id).with('search')
      subject.find_by_id('search')
    end
  end


  describe "#find_by_id" do
    subject { DiscoveryQuery.new }
    let(:search_id) { "ndu_aleph000188916" }
    let(:search) {
      VCR.use_cassette 'discovery_query/find_by_id' do
        subject.find_by_id(search_id)
      end
    }

    it "searches the api for the result " do
      expect(HesburghAPI2::Discovery).to receive(:record).with('search')
      subject.find_by_id('search')
    end


    it "marshals a discovery record for the result" do
      expect(search).to be_instance_of(DiscoveryRecord)
    end
  end
end
