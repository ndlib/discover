require 'spec_helper'


describe ConvertLanguageCodes do

  let(:lang_result) { double(name: 'Name', present?: true ) }
  let(:no_lang_result) { double(present?: false ) }

  it " uses the language tranlator" do
    expect(LanguageList::LanguageInfo).to receive(:find).with('lang').and_return(lang_result)
    expect(ConvertLanguageCodes.call(['lang'])).to eq(["Name"])
  end

  it "translates eng" do
    expect(ConvertLanguageCodes.call(['eng'])).to eq(["English"])
  end

  it "translates ger" do
    expect(ConvertLanguageCodes.call(['ger'])).to eq(["German"])
  end

  it "returns the original code if the convert cannot find the code" do
    expect(LanguageList::LanguageInfo).to receive(:find).with('lang').and_return(no_lang_result)
    expect(ConvertLanguageCodes.call(['lang'])).to eq(["lang"])
  end

  it "returns nil if nothing is passed in" do
    expect(ConvertLanguageCodes.call(nil)).to be_nil
  end
end
