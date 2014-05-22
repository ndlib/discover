class InstitutionLinksDecorator < Draper::Decorator

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
    (object['fulltext'].present?)
  end

end
