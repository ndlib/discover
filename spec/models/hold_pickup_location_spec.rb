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
end
