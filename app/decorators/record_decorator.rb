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
      :published,
      :description,
      :general_notes,
      :subjects,
      :language,
      :identifier,
      :type,
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

  def published
    h.content_tag(:ul) do
      object.published.collect { | field | h.concat(h.content_tag(:li, field)) }
    end
  end

  def description
    object.description
  end

  def general_notes
    object.general_notes
  end

  def subjects
    h.content_tag(:ul) do
      object.subjects.collect { | field | h.concat(h.content_tag(:li, field)) }
    end
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

  def record_ids
    h.content_tag(:ul) do
      object.record_ids.collect { | field | h.concat(h.content_tag(:li, field)) }
    end
  end

end
