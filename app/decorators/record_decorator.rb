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
      published: "Published"
    }
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

  def display_fields
    object.display_fields
  end
end
