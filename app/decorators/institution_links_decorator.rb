class InstitutionLinksDecorator < Draper::Decorator
  def id
    object['id']
  end

  def fulltext
    object['fulltext'].collect { | link | LinkDecorator.new(link) }
  end


  def ill
    LinkDecorator.new(object['ill'])
  end


  def report_a_problem
    LinkDecorator.new(object['report_a_problem'])
  end


  def has_fulltext_links?
    (fulltext.present? || sfx_link)
  end


  def sfx_link
    if object['findtext']
      SFXLinkDecorator.new(object['findtext']).link
    end
  end

end
