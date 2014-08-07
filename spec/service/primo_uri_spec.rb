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

  describe '#advanced_search' do
    it "links to the advanced search" do
      expect(subject.advanced_search('title', 'title')).to eq("/primo_library/libweb/action/search.do?fn=search&mode=Advanced&tab=onesearch&vid=NDU&vl%2816833817UI0%29=title&vl%281UIStartWith0%29=exact&vl%28freeText0%29=title&")
    end

    it "links to the advanced search with 2 sets of search params" do
      expect(subject.advanced_search('title', 'title', 'author', 'author')).to eq("/primo_library/libweb/action/search.do?fn=search&mode=Advanced&tab=onesearch&vid=NDU&vl%2816833817UI0%29=title&vl%281UIStartWith0%29=exact&vl%28freeText0%29=title&fn=search&mode=Advanced&tab=onesearch&vid=NDU&vl%2816833818UI1%29=author&vl%281UIStartWith1%29=exact&vl%28freeText1%29=author")
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

  describe '#advanced_search_scope_name' do
    it 'calls the primo_configuration' do
      expect(primo_configuration).to receive(:advanced_search_scope_name).and_return('scope_name')
      expect(subject.advanced_search_scope_name('0')).to eq('vl(scope_name)')
    end
  end

  describe '#advanced_search_scope_value' do
    it 'calls TranslateAdvancedSearchScope.call' do
      expect(TranslateAdvancedSearchScope).to receive(:call).and_return('translated')
      expect(subject.advanced_search_scope_value('scope')).to eq('translated')
    end

    it 'translates series' do
      expect(subject.advanced_search_scope_value('series')).to eq('lsr30')
    end
  end

  describe '#advanced_search_params' do
    it 'adds vl(freeText0) to #base_advanced_search_params and adds scope params' do
      expect(subject).to receive(:base_advanced_search_params).and_return({'test' => 'test'})
      expect(subject).to receive(:advanced_search_scope_name).and_return('scope_name')
      expect(subject).to receive(:advanced_search_scope_value).and_return('scope_value')
      expect(subject.advanced_search_params('scope', 'advanced')).to eq({'test' => 'test', 'vl(freeText0)' => 'advanced', 'scope_name' => 'scope_value', "vl(1UIStartWith0)"=>"exact"})
    end


    it "can search on the second search parameter" do
      #raise
    end

  end

  describe '#display_params' do
    it 'creates the params' do
      expect(subject.display_params('dedupmrg13765448')).to eq({"vid"=>"NDU", "tab"=>"onesearch", "doc"=>"dedupmrg13765448", "fn"=>"search", "ct"=>"display", "displayMode"=>"full", "tabs"=>"detailsTab"})
    end

    it 'can set the tab' do
      expect(subject.display_params('dedupmrg13765448', 'requestTab')).to eq({"vid"=>"NDU", "tab"=>"onesearch", "doc"=>"dedupmrg13765448", "fn"=>"search", "ct"=>"display", "displayMode"=>"full", "tabs"=>"requestTab"})
    end
  end

  describe '#display_no_base_path' do
    it 'creates the link' do
      expect(subject.display_no_base_path('dedupmrg13765448')).to eq("display.do?ct=display&displayMode=full&doc=dedupmrg13765448&fn=search&tab=onesearch&tabs=detailsTab&vid=NDU")
    end

    it 'can set the tab' do
      expect(subject.display_no_base_path('dedupmrg13765448', 'requestTab')).to eq("display.do?ct=display&displayMode=full&doc=dedupmrg13765448&fn=search&tab=onesearch&tabs=requestTab&vid=NDU")
    end
  end

  describe '#signin' do
    it 'creates a signin link to the target url' do
      expect(subject.signin('test')).to eq("/primo_library/libweb/action/login.do?loginFn=signin&tab=onesearch&targetURL=test&vid=NDU")
    end
  end


  describe '#request_tab_signin' do
    it 'creates a signin link to the request tab' do
      expect(subject.request_tab_signin('dedupmrg13765448')).to eq("/primo_library/libweb/action/login.do?loginFn=signin&tab=onesearch&targetURL=display.do%3Fct%3Ddisplay%26displayMode%3Dfull%26doc%3Ddedupmrg13765448%26fn%3Dsearch%26tab%3Donesearch%26tabs%3DrequestTab%26vid%3DNDU&vid=NDU")
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
