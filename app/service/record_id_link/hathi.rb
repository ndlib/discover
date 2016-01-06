class RecordIdLink::Hathi < Draper::Decorator
  def self.render(record_id, record)
    self.new(record_id).render(record)
  end

  def self.renders?(original_id)
    (original_id =~ /^hathi_pub/).present?
  end

  def record_id
    object.gsub(/^[^-]+-/, '')
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

  def render(record)
    h.link_to(title, url, target: '_blank')
  end

end
