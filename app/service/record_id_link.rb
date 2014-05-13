class RecordIdLink < Draper::Decorator

  def self.render(record_id)
    self.new(record_id).render
  end

  def self.render_classes
    [
      RecordIdLinkAleph
    ]
  end

  def render
    render_class.render(object)
  end

  def render_class
    self.class.render_classes.first
  end
end
