require 'spec_helper'

describe HoldItem do
  let(:data) do
    {
      "institution_code" => "BCI",
      "pickup_locations" => [
        {
          "code" => "BCI",
          "content" => "Bethel College"
        },
        {
          "code" => "HCC_B",
          "content" => "Holy Cross (allow extra time)"
        },
        {
          "code" => "NDU_B",
          "content" => "Hesburgh (allow extra time)"
        },
        {
          "code" => "SMC_B",
          "content" => "Saint Mary's(allow extra time)"
        }
      ],
      "description" => "v.2",
      "bib_id" => "000136357",
      "item_id" => "MLC200046090$$$BCI01000136357$$$BCI50000136357000020",
      "status_message" => "Requested",
      "location" => "B 72 .C62 1993"
    }
  end
  subject { described_class.new(data) }

  it 'has a description' do
    expect(subject.description).to eq('v.2')
  end

  it 'has a institution_code' do
    expect(subject.institution_code).to eq('BCI')
  end

  it 'has a bib_id' do
    expect(subject.bib_id).to eq('000136357')
  end

  it 'has a item_id' do
    expect(subject.item_id).to eq('MLC200046090$$$BCI01000136357$$$BCI50000136357000020')
  end

  it 'has a status_message' do
    expect(subject.status_message).to eq('Requested')
  end

  it 'has a location' do
    expect(subject.location).to eq('B 72 .C62 1993')
  end
end
