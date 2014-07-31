require 'spec_helper'

describe HoldVolume do
  let(:data) do
    {
      "description" => "v.1",
      "enumeration" => "1",
      "sort_order" => "1"
    }
  end

  subject { described_class.new(data) }

  it 'has a description' do
    expect(subject.description).to eq('v.1')
  end

  it 'has enumeration' do
    expect(subject.enumeration).to eq('1')
  end

  it 'has a sort_order' do
    expect(subject.sort_order).to eq('1')
  end
end
