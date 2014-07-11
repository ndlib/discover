require 'spec_helper'

describe OnlineAccessTab do
  let(:test_controller) { double(RecordsController, params: {})}
  subject { described_class.new(test_controller) }

  describe 'found record' do
    let(:record) { double(DiscoveryRecord) }

    before do
      subject.stub(:record).and_return(record)
    end

    it 'has specs'
  end

end
