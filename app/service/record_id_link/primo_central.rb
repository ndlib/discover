class RecordIdLink::PrimoCentral < Draper::Decorator
  def self.render(original_id)
    self.new(original_id).render
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

  def render
    "#{institution_name}: #{record_id}"
  end

end
