class RecordIdLinkLaw < Draper::Decorator
  def self.render(original_id)
    self.new(original_id).render
  end

  def self.renders?(original_id)
    (original_id =~ /^ndlaw_iii\./).present?
  end

  def id
    object
  end

  def record_id
    id.gsub(/^ndlaw_iii\./, '')
  end

  def institution_name
    h.t("institutions.ndlaw")
  end

  def render
    "#{institution_name}: #{record_id}"
  end

end
