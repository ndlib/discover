require 'spec_helper'


describe HoldsTab do
  let(:params) { {id: 'dedupmrg47445220', patron_id: 'patron_id'} }
  let(:test_controller) { double(HoldsController, params: params)}
  subject { described_class.new(test_controller) }

  it 'has a record id' do
    expect(subject.id).to eq(params[:id])
  end

  it 'has a patron id' do
    expect(subject.patron_id).to eq('patron_id')
  end

  it 'has a default cancel date' do
    expect(subject.default_cancel_date).to eq(Date.today.since(6.months))
  end

  it 'has a default cancel date string' do
    expect(subject.default_cancel_date_string).to eq(Date.today.since(6.months).strftime('%m/%d/%Y'))
  end
end
