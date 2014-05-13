require 'spec_helper'

describe RecordIdLinkLaw do
  let(:record_id) { 'ndlaw_iii.b18599291' }
  subject { described_class.new(record_id) }

  describe '#record_id' do
    it 'is the pc record id' do
      expect(subject.record_id).to eq("b18599291")
    end
  end

  describe '#institution_name' do
    it 'is Notre Dame' do
      expect(subject.institution_name).to eq('Notre Dame Law School')
    end
  end

  describe '#url' do
    it 'is a url to the law catalog record' do
      expect(subject.url).to eq("http://encore.law.nd.edu/iii/encore/record/C__Rb18599291?lang=eng")
    end
  end

  describe '#title' do
    it 'is the labeled record id' do
      expect(subject.title).to eq("Notre Dame Law School: b18599291")
    end
  end

  describe '#render' do
    it 'is a link to the law catalog record' do
      expect(subject.render).to eq("<a href=\"http://encore.law.nd.edu/iii/encore/record/C__Rb18599291?lang=eng\">Notre Dame Law School: b18599291</a>")
    end
  end
end
