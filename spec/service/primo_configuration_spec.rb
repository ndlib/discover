require 'spec_helper'

describe PrimoConfiguration do
  let(:vid) { 'NDU' }
  subject { described_class.new(vid)}

  describe '#vid_configuration' do
    it 'loads the vid config' do
      expect(subject.vid_configuration).to be_a_kind_of(Hash)
    end
  end
end
