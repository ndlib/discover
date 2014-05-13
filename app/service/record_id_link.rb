class RecordIdLink < Draper::Decorator

  def self.render(record_id)
    self.new(record_id).render
  end

  def self.render_classes
    [
      RecordIdLinkAleph,
      RecordIdLinkPrimoCentral,
      RecordIdLinkLaw
    ]
  end

  def render
    if render_class.present?
      render_class.render(object)
    else
      object
    end
  end

  def render_class
    class_to_render = nil
    self.class.render_classes.each do |klass|
      if klass.renders?(object)
        class_to_render = klass
      end
    end
    class_to_render
  end
end
