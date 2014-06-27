require 'spec_helper'

describe PrimoURI do
  let(:vid) { 'NDU' }
  let(:primo_configuration) { PrimoConfiguration.new(vid) }
  let(:tab) { 'onesearch' }
  subject { described_class.new(primo_configuration, tab)}

  describe '#basic_search' do
    it 'links to the search path' do
      expect(subject.basic_search('value')).to eq("/primo_library/libweb/action/search.do?fn=search&mode=Basic&tab=onesearch&vid=NDU&vl%28freeText0%29=value")
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

  describe '#base_params' do
    it 'is a HashWithIndifferentAccess' do
      expect(subject.base_params).to be_a_kind_of(HashWithIndifferentAccess)
    end

    it 'includes the vid and tab' do
      expect(subject.base_params.keys).to eq(["vid", "tab"])
      expect(subject.base_params[:vid]).to eq(vid)
      expect(subject.base_params[:tab]).to eq(tab)
    end
  end

  describe '#base_basic_search_params' do
    it 'extends #base_params' do
      expect(subject).to receive(:base_params).and_return(HashWithIndifferentAccess.new(vid: 'vid', tab: 'tab'))
      search_params = subject.base_basic_search_params
      expect(search_params[:vid]).to eq('vid')
      expect(search_params[:tab]).to eq('tab')
    end

    it 'defaults to basic search' do
      expect(subject.base_basic_search_params[:mode]).to eq('Basic')
    end

    it 'sets the fn to search' do
      expect(subject.base_basic_search_params[:fn]).to eq('search')
    end
  end

  describe '#base_advanced_search_params' do
    it 'extends #base_params' do
      expect(subject).to receive(:base_params).and_return(HashWithIndifferentAccess.new(vid: 'vid', tab: 'tab'))
      search_params = subject.base_advanced_search_params
      expect(search_params[:vid]).to eq('vid')
      expect(search_params[:tab]).to eq('tab')
    end

    it 'defaults to advanced search' do
      expect(subject.base_advanced_search_params[:mode]).to eq('Advanced')
    end

    it 'sets the fn to search' do
      expect(subject.base_advanced_search_params[:fn]).to eq('search')
    end
  end

  describe '#basic_search_params' do
    it 'adds vl(freeText0) to #base_basic_search_params' do
      expect(subject).to receive(:base_basic_search_params).and_return({'test' => 'test'})
      expect(subject.basic_search_params('basic')).to eq({'test' => 'test', 'vl(freeText0)' => 'basic'})
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
