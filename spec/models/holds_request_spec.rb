require 'spec_helper'


describe HoldsRequest do

  subject { described_class.new({}) }

  describe :save_params do
    it "saves the volume params" do
      subject.save_params({volume: '1'})
      expect(subject.volume).to eq("1")
    end

    it "saves the library param" do
      subject.save_params({library: '1'})
      expect(subject.library).to eq("1")
    end

    it "saves the pickup_location params" do
      subject.save_params({pickup_location: '1'})
      expect(subject.pickup_location).to eq("1")
    end


    it "saves the cancel_data params" do
      subject.save_params({pickup_location: '1'})
      expect(subject.pickup_location).to eq("1")
    end


    it "does not save extra keys" do
      subject.save_params({volume: 1, other_key: '2'})
      expect(subject.attributes).to eq({ :volume=>"1", :library=>nil, :pickup_location=>nil, :cancel_date=>nil })
    end

  end


  describe :initialize do

    it "allows you to passin attributes" do
      o = described_class.new(volume: '1', pickup_location: '2')
      expect(o.params).to eq({:volume=>"1", :library=>nil, :pickup_location=>"2", :cancel_date=>nil})
    end

  end

  describe :params do

    it "returns all the values when they are set" do
      o = described_class.new(volume: '1', pickup_location: '2', cancel_date: '10-10-1010', library: '3')
      expect(o.params).to eq({:volume=>"1", :library=>"3", :pickup_location=>"2", :cancel_date=>"10-10-1010"})
    end
  end


  describe :complete? do

    it "returns true when they are all set" do
      o = described_class.new(volume: '1', pickup_location: '2', library: '3')
      expect(o.complete?).to be_true
    end

    it "returns false when they are not all set" do
      expect(subject.complete?).to be_false
    end
  end
end
