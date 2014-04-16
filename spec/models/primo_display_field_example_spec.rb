require 'spec_helper'

describe PrimoDisplayFieldExample do
  describe '#body' do
    let(:array) { [1, 2, 3] }

    it "serializes the body" do
      subject.body = array
      subject.save!
      loaded = described_class.find(subject.id)
      expect(loaded.body).to eq(array)
    end
  end
end
