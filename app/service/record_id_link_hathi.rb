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

  def title
    "#{institution_name}: #{record_id}"
  end

  def url
    "http://catalog.hathitrust.org/Record/#{record_id}"
  end

  def render
    h.link_to(title, url, target: '_blank')
  end

end
