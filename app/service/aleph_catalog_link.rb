class AlephCatalogLink < Draper::Decorator
  def id
    object
  end

  def system_number
    object.gsub(/[^\d]+/,'')
  end

  def direct_path
    "/F/?func=direct&doc_number=#{system_number}"
  end

  def search_path
    "/F/?func=scan&scan_code=SYS&scan_start=#{system_number}"
  end
end
