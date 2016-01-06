class RecordIdLink::Law < Draper::Decorator
  def self.render(record_id, record)
    self.new(record_id).render(record)
  end

  def self.renders?(original_id)
    (original_id =~ /^ndlaw_iii\./).present?
  end

  def record_id
    object.gsub(/^ndlaw_iii\./, '')
  end

  def institution_name
    h.t("institutions.ndlaw")
  end

  def url
    "http://innopac.law.nd.edu/record=#{record_id}*eng"
  end

  def title
    "#{institution_name}: #{record_id}"
  end

  def render(record)
    h.link_to(title, url, target: '_blank')
  end

end
