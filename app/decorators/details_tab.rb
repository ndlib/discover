class DetailsTab < PrimoRecordTab

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
      :isbn, :issn, :eissn, :doi, :pmid, :lccn, :oclc
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

  def links_methods
    [
      :worldcat_link,
      :record_ids
    ]
  end


  def display_fields
    record.display_fields
  end

  def page_title
    record.title.first
  end

  def title
    ulize_array(record.title)
  end

  def author
    hierarchical_links_ul(:creator, record.creator)
  end

  def contributor
    hierarchical_links_ul(:creator, record.contributor)
  end

  def published
    ulize_array(record.published)
  end

  def description
    ulize_array(record.description)
  end

  def general_notes
    ulize_array(record.general_notes)
  end

  def series
    SeriesSearchLinks.render(record.series, primo_uri)
  end

  def subjects
    hierarchical_links_ul(:subject, record.subjects)
  end

  def contents
    ulize_array(record.contents)
  end

  def language
    languages = ConvertLanguageCodes.call(record.language)
    ulize_array(languages)
  end

  def identifiers
    labeled_hash = {}
    record.identifiers.each do |key, value|
      title = h.content_tag(:span, key, title: I18n.t("identifiers.#{key}"))
      labeled_hash[title] = value
    end
    dlize_hash(labeled_hash)
  end

  def type
    record.type
  end

  def source
    ulize_array(record.source)
  end

  def uniform_titles
    hierarchical_links_ul(:uniform_title, record.uniform_titles)
  end

  def record_ids
    ulize_array(linked_record_ids)
  end

  def linked_record_ids
    record.record_ids.collect { | record_id | RecordIdLink.render(record_id) }
  end

  def oclc
    if @oclc.nil?
      # We need to strip any leading zeroes from the oclc numbers
      @oclc = record.oclc.collect{|o| o.gsub(/^0+/,'')}
    end

    ulize_array(@oclc)
  end

  def isbn
    ulize_array(record.isbn)
  end

  def issn
    ulize_array(record.issn)
  end

  def eissn
    ulize_array(record.eissn)
  end

  def doi
    ulize_array(record.doi)
  end

  def pmid
    ulize_array(record.pmid)
  end

  def lccn
    ulize_array(record.lccn)
  end

  def earlier_title
    ulize_array(record.earlier_title)
  end

  def later_title
    ulize_array(record.later_title)
  end

  def supplement
    ulize_array(record.supplement)
  end

  def supplement_to
    ulize_array(record.supplement_to)
  end

  def issued_with
    ulize_array(record.issued_with)
  end

  def links
    links_array = links_methods.collect{ |method| send(method) }
    links_array.compact!
    ulize_array(links_array)
  end

  def variant_title
    ulize_array(record.variant_title)
  end

  def worldcat_identifier
    if @worldcat_identifier.nil?
      [:oclc, :isbn, :issn].each do |method|
        value = record.send(method)
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
      h.link_to(h.raw(h.t('details.record.link_labels.worldcat')), url)
    else
      nil
    end
  end

  def t(key)
    h.raw(h.t("record.#{key}"))
  end

  private
    def hierarchical_field(scope, values)
      HierarchicalField.new(scope, values)
    end

    def hierarchical_links(scope, values)
      field = hierarchical_field(scope, values)
      HierarchicalLinks.render(field, primo_uri)
    end

    def hierarchical_links_ul(scope, values)
      links = hierarchical_links(scope, values)
      ulize_array(links)
    end

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
end
