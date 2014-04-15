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
      record_id: "Record ID"
    }
  end

  def display_fields
    object.display_fields
  end

  def title
    object.title
  end

  def author
    object.creator_contributor
  end

  def published
    object.publisher_provider
  end

  def description
    "Description Stub"
  end

  def general_notes
    "General Notes Stub"
  end

  def subjects
    "Subjects Stub"
  end

  def language
    "Language Stub"
  end

  def identifier
    "Identifier Stub"
  end

  def type
    "Type Stub"
  end

  def record_id
    "Record ID Stub"
  end
end
