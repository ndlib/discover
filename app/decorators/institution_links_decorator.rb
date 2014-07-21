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
    if get(:report_a_problem)
      @report_a_problem ||= LinkDecorator.new(get(:report_a_problem))
    else
      nil
    end
  end

  def display_report_a_problem?
    false
  end

  def report_a_problem_link
    if report_a_problem.present?
      report_a_problem.link
    else
      nil
    end
  end


  def has_fulltext_links?
    (fulltext.present? || sfx_link)
  end

  def display_sfx_link?
    if sfx_link_decorator.present?
      sfx_link_decorator.from_primo?
    else
      false
    end
  end

  def sfx_link_decorator
    if object['findtext']
      @sfx_link_decorator ||= SFXLinkDecorator.new(object['findtext'])
    end
    @sfx_link_decorator
  end

  def sfx_link
    if display_sfx_link?
      sfx_link_decorator.link
    else
      nil
    end
  end

  def finding_aids
    get(:finding_aids).collect { |link| LinkDecorator.new(link) }
  end

  def finding_aid_links
    finding_aids.collect{ |decorator| decorator.link }
  end

  private

    def get(key)
      object[key.to_s]
    end

end
