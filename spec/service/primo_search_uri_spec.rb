require 'spec_helper'


describe PrimoSearchUri do
  subject { PrimoSearchUri }

  TYPE_TRANSLATIONS = { 'creator' => 'creator', 'title' => 'title', 'series' => 'lsr30', 'uniform_title' => 'lsr31', 'related_title' => 'title', 'subject' => 'sub' }

  describe :type_translator do
    subject {PrimoSearchUri::TranslateType}

    TYPE_TRANSLATIONS.each do | type, output |
      it "translates #{type} to #{output}" do
        expect(subject.call(type)).to eq(output)
      end
    end

    it "downcases the input " do
      txt = "TTTT"
      expect(txt).to receive(:downcase)

      subject.call(txt)
    end


    it "returns what is passed in if it is not one of the translations" do
      expect(subject.call("tyuiop")).to eq("tyuiop")
    end
  end


  it "calls the type translator" do
    expect(PrimoSearchUri::TranslateType).to receive(:call).with('title').and_return('title')
    subject.call('search', 'title')
  end


  describe :uri do

   TYPE_TRANSLATIONS.each do | type, search_type |
      it "searches on the type, #{type} with a value of #{search_type}" do
        expect(PrimoSearchUri.call('search', type)).to match("vl%2816833817UI0%29=#{search_type}")
      end
    end


    it "searchs the advanced tab" do
      expect(PrimoSearchUri.call('search', 'title')).to match("mode=Advanced")
    end


    it "runs and exact search" do
      expect(PrimoSearchUri.call('search', 'title')).to match("vl%281UIStartWith0%29=exact")
    end
  end


  describe :validations do

    it "raises an exception if there is no search" do
      expect { subject.call(nil, "title") }.to raise_error
    end

    it "raises an exception if there is no type" do
      expect { subject.call("search", nil) }.to raise_error
    end

    it "raise an exception if the type is not valid " do
      expect { subject.call("search", "not_a_type") }.to raise_error
    end

    TYPE_TRANSLATIONS.keys.each do | type |
      it "#{type} is valid type input" do
        expect{ subject.new("search", type)}.to_not raise_error
      end
    end
  end


  it "has a base url that points at primo 4" do
    expect(subject::BASE_URI).to eq("http://primo-fe1.library.nd.edu:1701/primo_library/libweb/action/search.do")
  end
end
