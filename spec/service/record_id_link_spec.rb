require 'spec_helper'

describe RecordIdLink do
  subject { described_class.new(nil) }

  describe '#render_class' do
    it 'renders for Aleph' do
      subject.stub(:object).and_return 'ndu_aleph12345'
      expect(subject.render_class).to eq(RecordIdLinkAleph)
    end
  end
end
