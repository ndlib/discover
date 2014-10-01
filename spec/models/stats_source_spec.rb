require 'spec_helper'


describe StatsSource do
  subject {described_class}

  describe :get_source do
    it "creates a new source when there is no existing one" do
      expect(subject.all.size).to eq(0)
      subject.get_source('primo_id', 'source')
      expect(subject.all.size).to eq(1)
    end

    it "returns a stat source" do
      expect(subject.get_source('primo_id', 'source').class).to be(described_class)
    end

    it "uses an existing source if there is already one " do
      source = subject.get_source('primo_id', 'source')
      subject.get_source('primo_id', 'source')
      expect(subject.all.size).to eq(1)
    end

  end
end
