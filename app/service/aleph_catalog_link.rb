class AlephCatalogLink < Draper::Decorator
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
    "#{institution_name}: #{system_number}"
  end

  def direct_link
    if aleph_record?
      h.link_to(direct_link_title, direct_url)
    else
      id
    end
  end
end
