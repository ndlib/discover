class RecordIdLinkHathi < Draper::Decorator
  def self.render(original_id)
    self.new(original_id).render
  end

  def self.renders?(original_id)
    (original_id =~ /^hathi_pub/).present?
  end

  def id
    object
  end

  def record_id
    id.gsub(/^[^-]+-/, '')
  end

  def institution_name
    h.t("institutions.hathi")
  end

  def render
    "#{institution_name}: #{record_id}"
  end

end
