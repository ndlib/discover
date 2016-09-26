require 'spec_helper'

describe SeriesSearchLinks do
  let(:primo_uri) { double(PrimoURI) }
  subject { described_class }

  it "returns nil if there are no series passed in " do
    expect(subject.render([], primo_uri)).to be_nil
  end

  it "returns links if there are series passed in " do
    primo_uri.stub(:advanced_search).and_return('url')
    expect(subject.render([{ "series_title" => "Rowling, J. K. Harry Potter series", "series_volume" => "3." }], primo_uri)).to eq("<ul class=\"ndl-series-search\"><li class=\"ndl-series-search-1\"><a title=\"Search for &quot;Rowling, J. K. Harry Potter series&quot;\" href=\"url\">Rowling, J. K. Harry Potter series</a>; <span>3.</span></li></ul>")
  end
end
