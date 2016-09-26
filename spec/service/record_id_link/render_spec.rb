require 'spec_helper'

describe RecordIdLink::Render do
  let(:record) { {"title" => "title", "url" => "url"} }
  let(:record_no_url) { {"title" => "title", "url" => ""} }

  describe '#render' do
    it 'renders a link' do
      expect(described_class.render(record)).to match("<a.*>title</a>")
    end

    it "renders a link with target blank" do
      expect(described_class.render(record)).to match("<a.*target=\"_blank\".*</a>")
    end

    it "renders the link with the title" do
      expect(described_class.render(record)).to match("<a.*>title</a>")
    end

    it "renders the title with no link if there is no url" do
      expect(described_class.render(record_no_url)).to match("title")
    end
  end
end
