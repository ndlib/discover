class RecordDecorator < Draper::Decorator

  def self.find(id)
    record = DiscoveryQuery.find_by_id(id)
    self.new(record)
  end

  def detail_content
    if @detail_content.nil?
      @detail_content = []
      detail_methods.each do |method, label|
        method_content = self.send(method)
        if method_content.present?
          @detail_content << [label, method_content]
        end
      end
    end
    @detail_content
  end

  def detail_methods
    {
      title: "Title",
      author: "Author",
      published: "Published",
      description: "Description",
      general_notes: "General Notes",
      subjects: "Subjects",
      language: "Language",
      identifier: "Identifier",
      type: "Type",
      record_ids: "Record IDs"
    }
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
    ret = []
    ret << object.edition if object.edition
    ret << object.publisher if object.publisher
    ret << object.creation_date if object.creation_date
    ret << object.format if object.format

    ret
  end

  def description
    object.description
  end

  def general_notes
    object.general_notes
  end

  def subjects
    object.subjects
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
    object.record_ids
  end
end
