require 'spec_helper'

describe HierarchicalField do
  let(:field) do
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

  subject { described_class.new(field) }

  describe '#search_values' do
    it 'concatenates the hierarchical values to search values' do
      expect(subject.search_values).to eq([["Caulfield, Holden [Fictitious character]", "Caulfield, Holden [Fictitious character] Fiction"], ["Runaway teenagers", "Runaway teenagers Fiction"], ["New York [N.Y.]", "New York [N.Y.] Fiction"]])
    end
  end
end
