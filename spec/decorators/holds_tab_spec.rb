require 'spec_helper'


describe HoldsTab do
  let(:params) { {id: 'dedupmrg47445220', patron_id: 'patron_id', vid: 'NDU'} }
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

  describe '#base_institution_code' do
    it 'strips anything after an underscore' do
      expect(subject.base_institution_code('NDU_B')).to eq('NDU')
    end

    it 'does not modify a string without an underscore' do
      expect(subject.base_institution_code('BCI')).to eq('BCI')
    end

    it 'translates HESB to NDU' do
      expect(subject.base_institution_code('HESB')).to eq('NDU')
    end
  end

  describe '#same_institution?' do
    it 'is true for NDU' do
      expect(subject.same_institution?('NDU')).to be_true
      expect(subject.same_institution?('NDU_B')).to be_true
      expect(subject.same_institution?('HESB')).to be_true
    end

    it 'is false for BCI' do
      expect(subject.same_institution?('BCI')).to be_false
      expect(subject.same_institution?('BCI_N')).to be_false
    end

    it 'is true for BCI' do
      subject.stub(:vid).and_return('BCI')
      expect(subject.same_institution?('BCI')).to be_true
      expect(subject.same_institution?('BCI_N')).to be_true
    end
  end
end
