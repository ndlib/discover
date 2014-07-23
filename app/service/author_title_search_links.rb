class AuthorTitleSearchLinks < Draper::Decorator

  def self.render(field, primo_uri)
    self.new(field).render_group(primo_uri)
  end


  def render_group(primo_uri)
    h.content_tag(:ul, class: 'ndl-author-title-search') do
      object.collect do |li|
        h.concat(group_li(li, primo_uri))
      end
    end
  end

  def group_li(title_author, primo_uri)
    h.content_tag(:li, link_to_advanced_search(title_author, primo_uri))
  end


  def link_to_advanced_search(title_author, primo_uri)
    h.link_to(title(title_author), primo_uri.advanced_search(:title, title_author['title'], :creator, title_author['author']), title: "Search for \"#{}\"")
  end


  def title(title_author)
    "#{title_author['title']} #{title_author['author'].present? ? " / #{title_author['author']}" : '' }"
  end

end

