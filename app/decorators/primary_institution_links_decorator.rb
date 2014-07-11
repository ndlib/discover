class PrimaryInstitutionLinksDecorator < InstitutionLinksDecorator

  def display_sfx_link?
    if sfx_link_decorator.present?
      if sfx_link_decorator.targets_loaded?
        sfx_link_decorator.number_of_targets > 0
      else
        true
      end
    else
      false
    end
  end

end
