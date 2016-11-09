require "spec_helper"

describe ApplicationHelper do
  notes = "notes"
  code = "library_code"
  current = "Currently received."

  describe "#non_current" do
    let(:testList) {[
      { code => "HESB", notes => "" },
      { code => "REF", notes => "" },
      { code => "ANNEX", notes => "" },
      { code => "other", notes => "" },
    ]}

    let(:expected) {[
      { code => "REF", notes => "" },
      { code => "other", notes => "" },
      { code => "HESB", notes => "" },
      { code => "ANNEX", notes => "" },
    ]}

    it "orders correctly" do
      sorted = helper.order_holdings_list(testList)
      expect(sorted).to eq(expected)
    end
  end

  describe "#with_current" do
    let(:testList) {[
      { code => "HESB", notes => "" },
      { code => "REF", notes => "" },
      { code => "ANNEX", notes => current },
      { code => "other", notes => "" },
    ]}

    let(:expected) {[
      { code => "ANNEX", notes => current },
      { code => "REF", notes => "" },
      { code => "other", notes => "" },
      { code => "HESB", notes => "" },
    ]}

    it "orders correctly" do
      sorted = helper.order_holdings_list(testList)
      expect(sorted).to eq(expected)
    end
  end

end
