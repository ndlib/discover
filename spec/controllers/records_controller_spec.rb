require 'spec_helper'

describe RecordsController do
  describe '#show' do
    it 'is a success' do
      get :show, id: 'ndu_aleph000188916'
      expect(response).to be_success
    end
  end
end
