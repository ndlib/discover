require 'spec_helper'

describe TranslateAdvancedSearchScope do
  TRANSLATIONS = { 'creator' => 'creator', 'title' => 'title', 'series' => 'lsr30', 'uniform_title' => 'lsr31', 'related_title' => 'title', 'subject' => 'sub' }


  TRANSLATIONS.each do |scope, output|
    describe scope do
      subject { described_class.new(scope) }

      it "translates to #{output}" do
        expect(subject.translate).to eq(output)
      end
    end
  end

  describe 'self' do
    let(:instance) { double(described_class) }
    subject { described_class }

    describe '#call' do
      it 'calls translate a new instance' do
        expect(subject).to receive(:new).with('scope').and_return(instance)
        expect(instance).to receive(:translate).and_return('scope_translated')
        expect(subject.call('scope')).to eq('scope_translated')
      end
    end
  end
end
