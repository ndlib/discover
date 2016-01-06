require 'spec_helper'

describe RecordIdLink::Law do
  let(:record_id) { 'ndlaw_iii.b1349952' }
  let(:record) { double }
  subject { described_class.new(record_id) }

  describe '#record_id' do
    it 'is the pc record id' do
      expect(subject.record_id).to eq("b1349952")
    end
  end

  describe '#institution_name' do
    it 'is Notre Dame' do
      expect(subject.institution_name).to eq('Notre Dame Law School')
    end
  end

  describe '#url' do
    it 'is a url to the law catalog record' do
      expect(subject.url).to eq("http://innopac.law.nd.edu/record=b1349952*eng")
    end
  end

  describe '#title' do
    it 'is the labeled record id' do
      expect(subject.title).to eq("Notre Dame Law School: b1349952")
    end
  end

  describe '#render' do
    it 'is a link to the law catalog record' do
      expect(subject.render(record)).to eq("<a href=\"http://innopac.law.nd.edu/record=b1349952*eng\" target=\"_blank\">Notre Dame Law School: b1349952</a>")
    end
  end
end
