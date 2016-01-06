class RecordIdLink::Aleph < Draper::Decorator
  def self.render(record_id)
    self.new(record_id).render
  end

  def self.renders?(record_id)
    (record_id =~ /_aleph/).present?
  end

  def id
    object
  end

  def aleph_record?
    (id =~ /_aleph/).present?
  end

  def institution_code
    id.gsub(/_.*/,'')
  end

  def institution_name
    h.t("institutions.#{institution_code}")
  end

  def system_number
    id.gsub(/[^\d]+/,'')
  end

  def local_base
    "#{institution_code}01pub"
  end

  def host
    "https://alephprod.library.nd.edu"
  end

  def direct_path
    "/F/?func=direct&doc_number=#{system_number}&local_base=#{local_base}"
  end

  def direct_url
    "#{host}#{direct_path}"
  end

  def direct_link_title
    if institution_code.present?
      "#{institution_name}: #{system_number}"
    else
      id
    end
  end

  def render
    h.link_to(direct_link_title, direct_url, target: '_blank')
  end
end
