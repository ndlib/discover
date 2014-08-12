require 'spec_helper'

describe HoldPickupLocation do
  let(:data) do
    {
      "code" => "HESB",
      "content" => "Hesburgh Library"
    }
  end

  subject { described_class.new(data) }

  it 'has a id' do
    expect(subject.id).to eq('HESB')
  end

  it 'has a title' do
    expect(subject.title).to eq('Hesburgh Library')
  end

  describe '#institution_code' do
    it 'returns the code' do
      expect(subject.institution_code).to eq('HESB')
    end

    it 'strips any non-alpha characters' do
      expect(subject).to receive(:get).with(:code).and_return('BCI50')
      expect(subject.institution_code).to eq('BCI')
    end
  end
end
