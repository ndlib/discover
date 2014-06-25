require 'spec_helper'

describe PrimoURI do
  subject { described_class.new('NDU', 'onesearch')}

  describe '#search_path' do
    it 'links to the search path' do
      expect(subject.search_path).to eq("/primo_library/libweb/action/search.do?fn=search&mode=Basic&tab=onesearch&vid=NDU")
    end
  end
end
