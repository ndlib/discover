require 'spec_helper'

describe HierarchicalLinks do
  let(:hierarchical_field) { double(HierarchicalField, search_values: [], scope: 'subject') }
  let(:primo_uri) { double(PrimoURI) }
  let(:simple_group) { [["link1","link1"], ["link2","link1 link2"]] }
  let(:single_link) { [["link1","link1"]] }

  subject { described_class.new(hierarchical_field) }

  describe '#group_links' do
    it 'creates an array of links' do
      primo_uri.stub(:advanced_search).and_return('url')
      expect(subject.group_links(simple_group, primo_uri)).to eq(["<a href=\"url\" title=\"Search for &quot;link1&quot;\">link1</a>", "<a href=\"url\" title=\"Search for &quot;link1 link2&quot;\">link2</a>"])
    end

    it "uses the primo uri service to generate the urls" do
      expect(primo_uri).to receive(:advanced_search).with('subject', 'link1').and_return('/')
      subject.render_group(single_link, primo_uri)
    end
  end

  describe '#group_lis' do
    it 'puts lis around #group_links' do
      expect(subject).to receive(:group_links).with(simple_group, primo_uri).and_return(['link1', 'link2'])
      expect(subject.group_lis(simple_group, primo_uri)).to eq(["<li class=\"ndl-hierarchical-search-1\">link1</li>", "<li class=\"ndl-hierarchical-search-2\">link2</li>"])
    end
  end

  describe "#render_group" do

    it "create a ul using #group_lis" do
      expect(subject).to receive(:group_lis).with(simple_group, primo_uri).and_return([])
      expect(subject.render_group(simple_group, primo_uri)).to eq("<ul class=\"ndl-hierarchical-search\"></ul>")
    end

    it "concatenates lis" do
      subject.stub(:group_links).and_return(['link1', 'link2'])
      expect(subject.render_group(simple_group, primo_uri)).to eq("<ul class=\"ndl-hierarchical-search\"><li class=\"ndl-hierarchical-search-1\">link1</li><li class=\"ndl-hierarchical-search-2\">link2</li></ul>")
    end
  end

  describe 'self' do
    let(:instance) { double(described_class) }
    subject { described_class }

    describe '#render' do
      it 'calls render_link_groups a new instance' do
        expect(subject).to receive(:new).with(hierarchical_field).and_return(instance)
        expect(instance).to receive(:render_link_groups).with(primo_uri).and_return('rendered')
        expect(subject.render(hierarchical_field, primo_uri)).to eq('rendered')
      end
    end
  end

end
