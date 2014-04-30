class HierarchicalSearchLinks < Draper::Decorator


  def self.render(search, type)
    self.new(search).render(type)
  end


  def render(type)
    h.content_tag(:ul, class: 'ndl-heiractical-search') do
      itereation = 1
      heirachical_links_array(type).collect do | item |
        h.concat(h.content_tag(:li, item, class: "ndl-heiractical-search-#{itereation}"))
        itereation += 1
      end
    end
  end


  private

    def split_search_for_heirarchy
      PrimoFieldSplitter.call(object)
    end


    def heirachical_links_array(type)
      ret = []
      total_search = ''

      split_search_for_heirarchy.each do | search |
        total_search += " #{search}"
        ret << h.link_to(search, PrimoSearchUri.call(total_search, type))
      end

      ret
    end

end
