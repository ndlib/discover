require 'spec_helper'

describe RecordIdLink::Hathi do
  let(:record_id) { 'hathi_pubMIU01-004528545' }
  subject { described_class.new(record_id) }

  describe '#record_id' do
    it 'is the pc record id' do
      expect(subject.record_id).to eq("004528545")
    end
  end

  describe '#institution_name' do
    it 'is Notre Dame' do
      expect(subject.institution_name).to eq('HathiTrust')
    end
  end

  describe '#url' do
    it 'is a url to the hathi trust' do
      expect(subject.url).to eq("http://catalog.hathitrust.org/Record/004528545")
    end
  end

  describe '#title' do
    it 'is the labeled record id' do
      expect(subject.title).to eq("HathiTrust: 004528545")
    end
  end

  describe '#render' do
    it 'is a link to the hathi trust' do
      expect(subject.render).to eq("<a href=\"http://catalog.hathitrust.org/Record/004528545\" target=\"_blank\">HathiTrust: 004528545</a>")
    end
  end
end
