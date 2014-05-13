class AlephCatalogLink < Draper::Decorator
  def id
    object
  end

  def institution_code
    id.gsub(/_.*/,'')
  end

  def system_number
    object.gsub(/[^\d]+/,'')
  end

  def local_base
    "#{institution_code}01pub"
  end

  def direct_path
    "/F/?func=direct&doc_number=#{system_number}&local_base=#{local_base}"
  end

  def search_path
    "/F/?func=scan&scan_code=SYS&scan_start=#{system_number}&local_base=#{local_base}"
  end
end
