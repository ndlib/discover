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
      :related_titles,
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
    object.creator
  end

  def contributor
    ulize_array(object.contributor)
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
    ulize_array(object.series)
  end

  def related_titles
    object.related_titles
  end

  def subjects
    ulize_array(object.subjects)
  end

  def contents
    ulize_array(object.contents)
  end

  def language
    object.language
  end

  def identifier
    object.identifier
  end

  def type
    object.type
  end

  def source
    object.source
  end

  def uniform_titles
    ulize_array(object.uniform_titles)
  end

  def record_ids
    ulize_array(object.record_ids)
  end

  private

    def ulize_array(arr)
      if arr.present?
        h.content_tag(:ul) do
          arr.collect { | item | h.concat(h.content_tag(:li, item)) }
        end
      end
    end


end
