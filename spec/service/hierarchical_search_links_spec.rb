require 'spec_helper'

describe HierarchicalSearchLinks do
  before(:each) do
    # shorten the url response since this is tested elsewhere
    PrimoSearchUri.stub(:call).and_return("url")
  end

  it "creates heirachical links when the separator is present" do
    expect(HierarchicalSearchLinks.render(["link1", "link2"], "series")).to eq("<ul class=\"ndl-hierarchical-search\"><li class=\"ndl-hierarchical-search-1\"><a href=\"url\" title=\"Search for &quot;link1 &quot;\">link1</a></li><li class=\"ndl-hierarchical-search-2\"><a href=\"url\" title=\"Search for &quot;link1 link2 &quot;\">link2</a></li></ul>")
  end

  it "fails over to just one link if there is no separator" do
    expect(HierarchicalSearchLinks.render(["link1"], "series")).to eq("<ul class=\"ndl-hierarchical-search\"><li class=\"ndl-hierarchical-search-1\"><a href=\"url\" title=\"Search for &quot;link1 &quot;\">link1</a></li></ul>")
  end

  it "uses the primo search uri service to generate the url" do
    expect(PrimoSearchUri).to receive(:call).with('link1 ', 'series')
    HierarchicalSearchLinks.render(["link1"], "series")
  end

end
