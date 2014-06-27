class HierarchicalLinks < Draper::Decorator

  delegate :scope, :search_values, to: :object

  def self.render(field, primo_uri)
    self.new(field).render_link_groups(primo_uri)
  end

  def render_link_groups(primo_uri)
    search_values.collect do |group|
      render_group(group, primo_uri)
    end
  end

  def render_group(group, primo_uri)
    h.content_tag(:ul, class: 'ndl-hierarchical-search') do
      group_lis(group, primo_uri).collect do |li|
        h.concat(li)
      end
    end
  end

  def group_lis(group, primo_uri)
    group_links(group, primo_uri).map.with_index do | link, index |
      h.content_tag(:li, link, class: "ndl-hierarchical-search-#{index + 1}")
    end
  end

  def group_links(group, primo_uri)
    group.collect do | title, search_text |
      link_to_advanced_search(title, search_text, primo_uri)
    end
  end

  def link_to_advanced_search(title, search_text, primo_uri)
    h.link_to(title, primo_uri.advanced_search(scope, search_text), title: "Search for \"#{search_text}\"")
  end

end
