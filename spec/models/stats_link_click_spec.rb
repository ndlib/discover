require 'spec_helper'


describe StatsLinkClick do
  subject { described_class}

  describe :record_click do
    it "uses the stat source" do
      expect(StatsSource).to receive(:get_source).and_return(StatsSource.create(primo_id: 'primo_id', source: 'source')).with('primo_id', 'source')
      subject.record_click('primo_id', 'source', 'title')
    end

    it "creates a new stats link click" do
      expect(subject.all.size).to eq(0)
      subject.record_click('primo_id', 'source', 'title')
      expect(subject.all.size).to eq(1)
    end
  end
end
