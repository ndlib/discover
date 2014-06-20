require "spec_helper"

describe "records/show.html.erb" do
  let(:search_id) { "ndu_aleph000188916" }

  let(:record) do
    VCR.use_cassette 'discovery_query/find_by_id/ndu_aleph000188916' do
      RecordDecorator.find(search_id, 'ndu')
    end
  end

  it "renders" do
    @record = record
    render
  end
end
