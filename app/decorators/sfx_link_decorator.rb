class SFXLinkDecorator < LinkDecorator

  def link
    h.link_to link_content, url, target: '_blank', class: 'ndl-sfx'
  end

  def link_content
    title_content + sfx_logo
  end

  def title_content
    h.content_tag(:span, title)
  end

  def sfx_logo
    h.image_tag(sfx_logo_url)
  end

  def sfx_logo_url
    if @sfx_logo_url.nil?
      uri = URI.parse(url)
      uri.query = nil
      uri.path += "/sfx.gif"
      @sfx_logo_url = uri.to_s
    end
    @sfx_logo_url
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
