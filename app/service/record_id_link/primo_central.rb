class RecordIdLink::PrimoCentral < Draper::Decorator
  def self.render(record_id, record)
    self.new(record_id).render(record)
  end

  def self.renders?(original_id)
    (original_id =~ /^TN_/).present?
  end

  def id
    object
  end

  def record_id
    id.gsub(/^TN_/, '')
  end

  def institution_name
    h.t("institutions.primo_central")
  end

  def render(record)
    "#{institution_name}: #{record_id}"
  end

end
