require 'spec_helper'

describe PrimoConfiguration do

  shared_examples_for "a primo configuration" do
    subject { described_class.new(vid)}

    describe '#vid' do
      it 'is the vid' do
        expect(subject.vid).to eq(vid)
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
      end
    end

    describe '#advanced_search_configuration' do
      it 'loads the advanced search config' do
        expect(subject.send(:advanced_search_configuration)).to be_a_kind_of(Hash)
      end
    end
  end


  describe 'NDU' do
    let(:vid) { 'NDU' }
    subject { described_class.new(vid)}

    it_behaves_like "a primo configuration"

    describe '#default_tab' do
      it 'is nd_campus' do
        expect(subject.default_tab).to eq('nd_campus')
      end
    end

    describe '#advanced_search_scope_name' do
      it 'is 16833817UI0' do
        expect(subject.advanced_search_scope_name).to eq('16833817UI0')
      end
    end
  end

  describe 'FAKE' do
    let(:vid) { 'FAKE' }
    subject { described_class.new(vid)}
    # Make sure an unknown vid does not throw any exceptions
    it_behaves_like "a primo configuration"

    describe '#default_tab' do
      it 'is nil' do
        expect(subject.default_tab).to be_nil
      end
    end

    describe '#advanced_search_scope_name' do
      it 'is nil' do
        expect(subject.advanced_search_scope_name).to be_nil
      end
    end
  end
end
