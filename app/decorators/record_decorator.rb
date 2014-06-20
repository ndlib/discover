class RecordDecorator < Draper::Decorator

  def self.find(id, vid)
    record = DiscoveryQuery.find_by_id(id, vid)
    self.new(record)
  end

  def detail_content(fields)
    detail_content = []
    fields.each do |method|
      method_content = self.send(method)
      if method_content.present?
        detail_content << [method, method_content]
      end
    end

    detail_content
  end


  def detail_methods
    [
      :description,
      :contents,
      :author,
      :contributor,
      :subjects,
      :series,
      #:is_part_of,
      :published,
      :source,
      :language,
      :general_notes,
      :type,
    ]
  end

  def identifiers_methods
    [
      :isbn, :issn, :eissn, :doi, :pmid, :lccn, :oclc, :record_ids
    ]
  end

  def other_titles_methods
    [
      :uniform_titles, :variant_title
    ]
  end


  def related_works_methods
    [
      :earlier_title, :later_title, :supplement, :supplement_to, :issued_with
    ]
  end


  def display_fields
    object.display_fields
  end

  def page_title
    object.title.first
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
    ulize_array(object.published)
  end

  def description
    ulize_array(object.description)
  end

  def general_notes
    ulize_array(object.general_notes)
  end

  def series
    SeriesSearchLinks.render(object.series, :series)
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
    ulize_array(object.source)
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
    if @oclc.nil?
      # We need to strip any leading zeroes from the oclc numbers
      @oclc = object.oclc.collect{|o| o.gsub(/^0+/,'')}
    end

    ulize_array(@oclc)
  end

  def isbn
    ulize_array(object.isbn)
  end

  def issn
    ulize_array(object.issn)
  end

  def eissn
    ulize_array(object.eissn)
  end

  def doi
    ulize_array(object.doi)
  end

  def pmid
    ulize_array(object.pmid)
  end

  def lccn
    ulize_array(object.lccn)
  end

  def earlier_title
    ulize_array(object.earlier_title)
  end

  def later_title
    ulize_array(object.later_title)
  end

  def supplement
    ulize_array(object.supplement)
  end

  def supplement_to
    ulize_array(object.supplement_to)
  end

  def issued_with
    ulize_array(object.issued_with)
  end

  def links
    links_array = [:worldcat_link].collect{ |method| send(method) }
    links_array.compact!
    ulize_array(links_array)
  end

  def variant_title
    ulize_array(object.variant_title)
  end

  def worldcat_identifier
    if @worldcat_identifier.nil?
      [:oclc, :isbn, :issn].each do |method|
        value = object.send(method)
        if value.present?
          @worldcat_identifier = [method, value.first]
          break
        end
      end
    end
    @worldcat_identifier
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
      h.link_to(h.t('details.record.link_labels.worldcat'), url)
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
