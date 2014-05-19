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
#      :links,
      :author,
      :contributor,
      :published,
      :description,
      :general_notes,
      :subjects,
      :contents,
      :language,
      :type,
      :source,
      :series,
      :uniform_titles,
      :identifiers,
      :record_ids
    ]
  end

  def display_fields
    object.display_fields
  end

  def title
    ulize_array(object.title)
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
    published = object.published.collect { | p | ulize_array(p) }
    ulize_array(published)
  end

  def description
    ulize_array(object.description)
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
    languages = ConvertLanguageCodes.call(object.language)
    ulize_array(languages)
  end

  def identifiers
    labeled_hash = {}
    object.identifiers.each do |key, value|
      title = h.content_tag(:span, key, title: I18n.t("identifiers.#{key}"))
      labeled_hash[title] = value
    end
    dlize_hash(labeled_hash)
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
    ulize_array(linked_record_ids)
  end

  def linked_record_ids
    object.record_ids.collect { | record_id | RecordIdLink.render(record_id) }
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

  def links
    links_array = [:worldcat_link].collect{ |method| send(method) }
    links_array.compact!
    ulize_array(links_array)
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

  def worldcat_link
    url = worldcat_url
    if url.present?
      h.link_to(t('link_labels.worldcat'), url)
    else
      nil
    end
  end

  def t(key)
    h.raw(h.t("record.#{key}"))
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
          hsh.collect { | key, values | h.concat(h.content_tag(:dt, key) + h.content_tag(:dd, ulize_array(values)))}
        end
      end
    end



    def create_heirarchical_links(field, search_type)
      field['hierarchical'].collect { | row | HierarchicalSearchLinks.render(row, search_type) }
    end

end
