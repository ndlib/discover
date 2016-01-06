class RecordIdLink::Render
  attr_reader :record, :record_id

  def self.render(record_id, record)
    new(record_id, record).render
  end

  def initialize(record_id, record)
    @record_id = record_id
    @record = record
  end

  def self.render_classes
    [
      RecordIdLink::Aleph,
      RecordIdLink::PrimoCentral,
      RecordIdLink::Law,
      RecordIdLink::Hathi,
      RecordIdLink::CRL,
    ]
  end

  def render
    if render_class.present?
      render_class.render(record_id, record)
    else
      record_id
    end
  end

  def render_class
    class_to_render = nil
    self.class.render_classes.each do |klass|
      if klass.renders?(record_id)
        class_to_render = klass
      end
    end
    class_to_render
  end
end
