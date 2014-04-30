require 'spec_helper'


describe PrimoFieldSplitter do

  it "splits on the -- " do
    test = 'part1--part2'
    expect(PrimoFieldSplitter.call(test)).to eq(['part1', 'part2'])
  end

  it "trims the results of each restults" do
    test = '  part1  --  part2  '
    expect(PrimoFieldSplitter.call(test)).to eq(['part1', 'part2'])
  end

  it "returns only the one result when there is no delimiter" do
    test = 'part1  part2'
    expect(PrimoFieldSplitter.call(test)).to eq([test])
  end

  it "returns nil when the nil is passed in" do
    test = nil
    expect(PrimoFieldSplitter.call(test)).to be_nil
  end


  it "returns empty string if the data is empty" do
    test = ''
    expect(PrimoFieldSplitter.call(test)).to eq('')
  end
end
