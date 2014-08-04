require 'spec_helper'

describe HoldVolume do

  subject { described_class.new(data) }

  describe 'multi volume' do
    let(:data) do
      {
        "description" => "v.1",
        "enumeration" => "1",
        "sort_order" => "10"
      }
    end

    it 'has a title' do
      expect(subject.title).to eq('v.1')
    end

    it 'has an id' do
      expect(subject.id).to eq('1')
    end

    it 'has a sort_order' do
      expect(subject.sort_order).to eq('10')
    end

    it 'is not a single volume' do
      expect(subject.single_volume?).to be_false
    end
  end

  describe 'single volume' do
    let(:data) do
      {
        "description" =>  "single_volume",
        "enumeration" =>  "1",
        "sort_order" =>  "1"
      }
    end

    it 'is a single volume' do
      expect(subject.single_volume?).to be_true
    end
  end
end
