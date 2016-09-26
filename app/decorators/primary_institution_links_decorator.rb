class PrimaryInstitutionLinksDecorator < InstitutionLinksDecorator

  def display_content?
    has_fulltext_links? || display_sfx_link?
  end

  def display_sfx_link?
    if sfx_link_decorator.present?
      true
    else
      false
    end
  end

  def display_report_a_problem?
    report_a_problem.present? && display_sfx_link?
  end

end
