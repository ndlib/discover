require "spec_helper"

describe "records/show.html.erb" do
  let(:search_id) { "ndu_aleph000188916" }

  let(:test_controller) { double(RecordsController, params: {id: search_id, vid: 'NDU', tab: 'onesearch'})}
  let(:tab) do
    detail_tab = nil
    VCR.use_cassette 'discovery_query/find_by_id/ndu_aleph000188916' do
      detail_tab = DetailsTab.new(test_controller)
      detail_tab.record
    end
    detail_tab
  end

  it "renders" do
    @tab = tab
    render
  end
end
