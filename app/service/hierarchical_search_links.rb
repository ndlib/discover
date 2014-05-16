class HierarchicalSearchLinks < Draper::Decorator


  def self.render(search, type)
    self.new(search).render(type)
  end


  def render(type)
    h.content_tag(:ul, class: 'ndl-hierarchical-search') do
      iteration = 1
      heirachical_links_array(type).collect do | item |
        h.concat(h.content_tag(:li, item, class: "ndl-hierarchical-search-#{iteration}"))
        iteration += 1
      end
    end
  end

  private

    def heirachical_links_array(type)
      ret = []
      total_search = ''

      object.each do | search |
        total_search += "#{search} "
        ret << h.link_to(search, PrimoSearchUri.call(total_search, type), title: h.raw("Search for &quot;#{total_search}&quot;"))
      end

      ret
    end

end
