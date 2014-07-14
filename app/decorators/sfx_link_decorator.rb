class SFXLinkDecorator < LinkDecorator

  def link
    h.link_to title, url, target: '_blank'
  end

  def title
    if targets_loaded?
      I18n.t('links.sfx.view')
    else
      I18n.t('links.sfx.search')
    end
  end

  def targets_loaded?
    get('targets_loaded')
  end

  def number_of_targets
    get('number_of_targets')
  end

end
