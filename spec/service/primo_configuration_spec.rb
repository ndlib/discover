require 'spec_helper'

describe PrimoConfiguration do
  let(:vid) { 'NDU' }
  subject { described_class.new(vid)}

  describe '#vid' do
    it 'is the vid' do
      expect(subject.vid).to eq('NDU')
    end
  end

  describe '#vid_configuration' do
    it 'loads the vid config' do
      expect(subject.send(:vid_configuration)).to be_a_kind_of(Hash)
    end
  end

  describe '#tabs' do
    it 'is an array' do
      expect(subject.tabs).to be_a_kind_of(Array)
      expect(subject.tabs.first).to eq('onesearch')
    end
  end
end
