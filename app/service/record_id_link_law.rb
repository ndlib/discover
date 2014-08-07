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

  def url
    "http://innopac.law.nd.edu/record=#{record_id}*eng"
  end

  def title
    "#{institution_name}: #{record_id}"
  end

  def render
    h.link_to(title, url)
  end

end
