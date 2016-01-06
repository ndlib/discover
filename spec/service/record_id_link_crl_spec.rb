require 'spec_helper'

describe RecordIdLinkCRL do
  let(:record_id) { "crlcat.b28583504" }

  subject { described_class.new(record_id) }

  describe "#renders?" do
    it "returns true for CRL records" do
      expect(described_class.renders?(record_id)).to be_true
    end

    it "returns false for non CRL records" do
      expect(described_class.renders?("ndu_aleph001890313")).to be_false
    end
  end

  describe "#render" do
    it "returns a link to CRL libraries" do
      expect(described_class.render(record_id)).to match(/^<a.*<\/a>/)
    end

    it "has the correct link title" do
      expect(described_class.render(record_id)).to match(/^<a.*>Center For Research Libraries<\/a>/)
    end

    it "has the correct href " do
      expect(described_class.render(record_id)).to include("href=\"http://catalog.crl.edu/record=b2858350\"")
    end

    it "removes the crlcat from the record_id" do
      expect(described_class.render(record_id)).to_not include("record=crlcat.b2858350")
    end

    it "removes the last character of the record id" do
      expect(described_class.render(record_id)).to_not include("record=b28583504")
    end

    it "correctly formats the CRL record id" do
      expect(described_class.render(record_id)).to include("record=b2858350")
    end
  end
end
