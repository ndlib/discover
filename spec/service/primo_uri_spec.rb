require 'spec_helper'

describe PrimoURI do
  let(:vid) { 'NDU' }
  let(:primo_configuration) { PrimoConfiguration.new(vid) }
  subject { described_class.new(primo_configuration, 'onesearch')}

  describe '#search_path' do
    it 'links to the search path' do
      expect(subject.search_path).to eq("/primo_library/libweb/action/search.do?fn=search&mode=Basic&tab=onesearch&vid=NDU")
    end
  end
end
