require 'spec_helper'


describe SeriesSearchLinks do
  subject { described_class }

  it "returns nil if there are no series passed in " do
    expect(SeriesSearchLinks.render([], :title)).to be_nil
  end

  it "returns links if there are series passed in " do
    expect(SeriesSearchLinks.render([{"series_title"=>"Rowling, J. K. Harry Potter series", "series_volume"=>"3."}], :series)).to eq("<ul class=\"ndl-series-search\"><li class=\"ndl-series-search-1\"><a href=\"http://primo-fe2.library.nd.edu:1701/primo_library/libweb/action/search.do?fn=search&amp;mode=Advanced&amp;tab=onesearch&amp;vid=NDU&amp;vl%2816833817UI0%29=lsr30&amp;vl%281UIStartWith0%29=exact&amp;vl%28freeText0%29=Rowling%2C+J.+K.+Harry+Potter+series\" title=\"Search for &quot;Rowling, J. K. Harry Potter series&quot;\">Rowling, J. K. Harry Potter series</a>; <span>3.</span></li></ul>")
  end

end
