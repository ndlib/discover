require 'spec_helper'

describe RecordIdLink do
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
      expect(subject.render_class).to eq(RecordIdLinkAleph)
    end
  end
end
