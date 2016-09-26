class RecordIdLink::Render < Draper::Decorator
  attr_reader :record

  def self.render(record)
    new(record).render
  end

  def initialize(record)
    @record = record
  end

  def render
    if record["url"]
      h.link_to(record["title"], record["url"], target: '_blank')
    else
      record["title"]
    end
  end
end
