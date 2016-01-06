require 'spec_helper'

describe RecordIdLink::Render do
  let(:record_id) { 'ndu_aleph12345' }
  subject { described_class.new(record_id) }

  describe '#render' do
    let(:render_class) { double() }

    it 'renders with render_class' do
      expect(render_class).to receive(:render)
      expect(render_class).to receive(:present?).and_return(true)
      subject.stub(:render_class).and_return(render_class)
      subject.render
    end

    it 'renders the record_id if there is no render_class' do
      expect(render_class).to receive(:present?).and_return(false)
      subject.stub(:render_class).and_return(render_class)
      expect(subject.render).to eq(record_id)
    end
  end

  describe 'Aleph' do
    let(:record_id) { 'ndu_aleph12345' }
    it '#render_class returns RecordIdLinkAleph' do
      expect(subject.render_class).to eq(RecordIdLink::Aleph)
    end
  end

  describe 'Primo Central' do
    let(:record_id) { 'TN_medline22021833' }
    it '#render_class returns RecordIdLinkPrimoCentral' do
      expect(subject.render_class).to eq(RecordIdLink::PrimoCentral)
    end
  end

  describe 'Law library' do
    let(:record_id) { 'ndlaw_iii.b18599291' }
    it '#render_class returns RecordIdLinkLaw' do
      expect(subject.render_class).to eq(RecordIdLink::Law)
    end
  end

  describe 'Hathi Trust' do
    let(:record_id) { 'hathi_pubMIU01-004528545' }
    it '#render_class returns RecordIdLinkHathi' do
      expect(subject.render_class).to eq(RecordIdLink::Hathi)
    end
  end

  describe 'CRL' do
    let(:record_id) { 'crlcat.b28583504' }
    it '#render_class returns RecordIdLinkCRL' do
      expect(subject.render_class).to eq(RecordIdLink::CRL)
    end
  end
end
