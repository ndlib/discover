require 'spec_helper'

describe HierarchicalField do
  let(:values) do
    {
      'fulltext' => [
        "Caulfield, Holden [Fictitious character] -- Fiction",
        "Runaway teenagers -- Fiction",
        "New York [N.Y.] -- Fiction"
        ],
      'hierarchical' => [
        [
          "Caulfield, Holden [Fictitious character]",
          "Fiction"
        ],
        [
          "Runaway teenagers",
          "Fiction"
        ],
        [
          "New York [N.Y.]",
          "Fiction"
        ]
      ]
    }
  end

  subject { described_class.new('scope', values) }

  describe '#scope' do
    it 'is the scope' do
      expect(subject.scope).to eq('scope')
    end
  end

  describe '#text_values' do
    it 'is the text values' do
      expect(subject.text_values).to eq(values['fulltext'])
    end
  end

  describe '#hierarchical_values' do
    it 'is the hierarchical values' do
      expect(subject.hierarchical_values).to eq(values['hierarchical'])
    end
  end

  describe '#search_values' do
    it 'gives the original value and concatenates the hierarchical values to search values' do
      expect(subject.search_values).to eq([
        [
          ["Caulfield, Holden [Fictitious character]", "Caulfield, Holden [Fictitious character]"],
          ["Fiction", "Caulfield, Holden [Fictitious character] Fiction"]
        ], [
          ["Runaway teenagers", "Runaway teenagers"],
          ["Fiction", "Runaway teenagers Fiction"]
        ],
        [
          ["New York [N.Y.]", "New York [N.Y.]"],
          ["Fiction", "New York [N.Y.] Fiction"]
        ]
      ])
    end
  end
end
