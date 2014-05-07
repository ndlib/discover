class RecordDecorator < Draper::Decorator

  def self.find(id)
    record = DiscoveryQuery.find_by_id(id)
    self.new(record)
  end

  def detail_content
    if @detail_content.nil?
      @detail_content = []
      detail_methods.each do |method|
        method_content = self.send(method)
        if method_content.present?
          @detail_content << [method, method_content]
        end
      end
    end
    @detail_content
  end

  def detail_methods
    [
      :title,
      :author,
      :contributor,
      :published,
      :description,
      :general_notes,
      :subjects,
      :contents,
      :language,
      :identifier,
      :type,
      :source,
      :series,
      :uniform_titles,
      :record_ids
    ]
  end

  def display_fields
    object.display_fields
  end

  def title
    object.title
  end

  def author
    author = create_heirarchical_links(object.creator, :creator)
    ulize_array(author)
  end

  def contributor
    contrib = create_heirarchical_links(object.contributor, :creator)

    ulize_array(contrib)
  end

  def published
    ulize_array(object.published)
  end

  def description
    object.description
  end

  def general_notes
    ulize_array(object.general_notes)
  end

  def series
    series = create_heirarchical_links(object.series, :series)
    ulize_array(series)
  end

  def subjects
    subs = create_heirarchical_links(object.subjects, :subject)
    ulize_array(subs)
  end

  def contents
    ulize_array(object.contents)
  end

  def language
    object.language
  end

  def identifier
    ulize_array(object.identifier)
  end

  def type
    object.type
  end

  def source
    object.source
  end

  def uniform_titles
    titles = create_heirarchical_links(object.uniform_titles, :uniform_title)
    ulize_array(titles)
  end

  def record_ids
    ulize_array(object.record_ids)
  end

  def oclc
    object_oclc = object.oclc
    if object_oclc.nil?
      nil
    else
      if @oclc.nil?
        @oclc = object_oclc
        @oclc.gsub!(/^0+/,'')
      end
      @oclc
    end
  end

  def isbn
    object.isbn
  end

  def issn
    object.issn
  end

  def worldcat_identifiers
    if @worldcat_identifiers.nil?
      @worldcat_identifiers = []
      [:oclc, :isbn, :issn].each do |method|
        value = self.send(method)
        if value.present?
          @worldcat_identifiers << [method, value]
        end
      end
    end
    @worldcat_identifiers
  end

  def worldcat_identifier
    worldcat_identifiers.first
  end

  def worldcat_url
    key,value = worldcat_identifier
    if key.present?
      "http://www.worldcat.org/#{key}/#{value}"
    else
      nil
    end
  end

  private

    def ulize_array(arr)
      if arr.present?
        h.content_tag(:ul) do
          arr.collect { | item | h.concat(h.content_tag(:li, h.raw(item))) }
        end
      end
    end


    def dlize_hash(hsh)
      if hsh.present?
        h.content_tag(:dl) do

        end
      end
    end



    def create_heirarchical_links(array, search_type)
      array.collect { | row | HierarchicalSearchLinks.render(row, search_type) }
    end

end
