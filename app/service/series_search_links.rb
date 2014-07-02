class SeriesSearchLinks < Draper::Decorator


  def self.render(search, primo_uri)
    self.new(search).render(primo_uri)
  end


  def render(primo_uri)
    links = series_links_array(primo_uri)
    if links.present?
      h.content_tag(:ul, class: 'ndl-series-search') do
        iteration = 1
        links.collect do | item |
          h.concat(h.content_tag(:li, item, class: "ndl-series-search-#{iteration}"))
          iteration += 1
        end
      end
    else
      nil
    end
  end

  private

    def series_links_array(primo_uri)
      if @series_links_array.nil?

        @series_links_array = []

        object.each do | search |
          @series_links_array << series_link(search, primo_uri) + series_volume(search)
        end
      end

      @series_links_array
    end


    def series_link(search, primo_uri)
      h.link_to(search['series_title'], primo_uri.advanced_search(:series, search['series_title']), title: "Search for \"#{search['series_title']}\"")
    end


    def series_volume(search)
      if search['series_volume']
        h.raw("; <span>#{search['series_volume']}</span>")
      else
        ""
      end
    end

end
