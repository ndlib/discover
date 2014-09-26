require 'spec_helper'


describe ConvertLanguageCodes do

  let(:lang_result) { double(name: 'Name', present?: true ) }
  let(:no_lang_result) { double(present?: false ) }

  subject { described_class }

  it " uses the language tranlator" do
    expect(LanguageList::LanguageInfo).to receive(:find).with('lang').and_return(lang_result)
    expect(subject.call(['lang'])).to eq(["Name"])
  end

  it "translates eng" do
    expect(subject.call(['eng'])).to eq(["English"])
  end

  it "translates ger" do
    expect(subject.call(['ger'])).to eq(["German"])
  end

  it "translates pro and converts ASCII 8 bit to UTF-8" do
    expect(subject.call(['pro'])).to eq(["Old Provençal (to 1500)"])
  end

  it "returns the original code if the convert cannot find the code" do
    expect(LanguageList::LanguageInfo).to receive(:find).with('lang').and_return(no_lang_result)
    expect(subject.call(['lang'])).to eq(["lang"])
  end

  it "returns nil if nothing is passed in" do
    expect(subject.call(nil)).to be_nil
  end
end
