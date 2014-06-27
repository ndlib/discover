require 'spec_helper'

describe PrimoURI do
  let(:vid) { 'NDU' }
  let(:primo_configuration) { PrimoConfiguration.new(vid) }
  let(:tab) { 'onesearch' }
  subject { described_class.new(primo_configuration, tab)}

  describe '#search_path' do
    it 'links to the search path' do
      expect(subject.search_path).to eq("/primo_library/libweb/action/search.do?fn=search&mode=Basic&tab=onesearch&vid=NDU")
    end
  end

  describe '#current_tab' do
    it 'is the tab that was passed in' do
      expect(subject.current_tab).to eq(tab)
    end
  end

  describe 'no current tab' do
    let(:tab) { nil }

    describe '#current_tab' do
      it 'defaults to the primo_configuration default tab' do
        expect(subject.current_tab).to eq(primo_configuration.default_tab)
      end
    end
  end

  describe '#base_path' do
    it 'is the base primo action path' do
      expect(subject.base_path).to eq("/primo_library/libweb/action")
    end

    it 'appends an action' do
      expect(subject.base_path('search.do')).to eq("/primo_library/libweb/action/search.do")
    end
  end

  describe 'self' do
    subject { described_class }

    describe '#new' do
      it 'accepts a PrimoConfiguration and current tab' do
        expect(subject.new(primo_configuration, 'nd_campus')).to be_a_kind_of(described_class)
      end

      it 'accepts a PrimoConfiguration without a current tab, and defaults to the default tab' do
        expect(subject.new(primo_configuration)).to be_a_kind_of(described_class)
      end
    end

  end
end
