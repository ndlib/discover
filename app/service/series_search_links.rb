class SeriesSearchLinks < Draper::Decorator


  def self.render(search, type)
    self.new(search).render(type)
  end


  def render(type)
    return nil if !series_links_array(type).present?

    h.content_tag(:ul, class: 'ndl-series-search') do
      iteration = 1
      series_links_array(type).collect do | item |
        h.concat(h.content_tag(:li, item, class: "ndl-series-search-#{iteration}"))
        iteration += 1
      end
    end
  end

  private

    def series_links_array(type)
      if @series_links_array.nil?

        @series_links_array = []

        object.each do | search |
          @series_links_array << series_link(search, type) + series_volume(search)
        end
      end

      @series_links_array
    end


    def series_link(search, type)
      h.link_to(search['series_title'], PrimoSearchUri.call(search['series_title'], type), title: h.raw("Search for &quot;#{search['series_title']}&quot;"))
    end


    def series_volume(search)
      if search['series_volume']
        h.raw("; <span>#{search['series_volume']}</span>")
      else
        ""
      end
    end

end
