class InstitutionLinksDecorator < Draper::Decorator

  def fulltext
    object['fulltext'].collect { | link | LinkDecorator.factory(link) }
  end


  def ill
    LinkDecorator.new(object['ill'])
  end


  def report_a_problem
    LinkDecorator.new(object['report_a_problem'])
  end


  def has_fulltext_links?
    (object['fulltext'].present?)
  end


  def sfx_link
    if object['findtext']
      LinkDecorator.new(object['findtext'])
    end
  end

end
