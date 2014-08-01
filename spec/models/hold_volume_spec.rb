require 'spec_helper'

describe HoldVolume do
  let(:data) do
    {
      "description" => "v.1",
      "enumeration" => "1",
      "sort_order" => "10"
    }
  end

  subject { described_class.new(data) }

  it 'has a title' do
    expect(subject.title).to eq('v.1')
  end

  it 'has an id' do
    expect(subject.id).to eq('1')
  end

  it 'has a sort_order' do
    expect(subject.sort_order).to eq('10')
  end
end
