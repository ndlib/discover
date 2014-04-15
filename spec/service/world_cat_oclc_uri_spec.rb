require 'spec_helper'

describe WorldCatOclcUri do
  subject{ WorldCatOclcUri }

  it "returns a link to world cat for the oclc number" do
    expect(subject.call('oclc')).to eq("http://www.worldcat.org/search?q=no%3Aoclc")
  end

  it "if there is no number it returns empty string" do
   expect(subject.call('')).to eq("")
  end

  it "returns empty if the number is nil" do
    expect(subject.call(nil)).to eq("")
  end

end
