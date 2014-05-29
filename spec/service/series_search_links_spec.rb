require 'spec_helper'


describe SeriesSearchLinks do
  subject { described_class }

  it "returns nil if there are no series passed in " do
    expect(SeriesSearchLinks.render([], :title)).to be_nil
  end

end
