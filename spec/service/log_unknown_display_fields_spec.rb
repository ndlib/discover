require 'spec_helper'

describe LogUnknownDisplayFields do
  let(:display_fields) { {title: 'Test Title', creator: 'John Doe'} }
  let(:discovery_record) { double(DiscoveryRecord, display_fields: display_fields) }

  describe 'self' do
    subject { described_class }

    describe '#call' do
      it 'calls #log on an instance' do
        expect_any_instance_of(subject).to receive(:log)
        subject.call(discovery_record)
      end
    end
  end
end
