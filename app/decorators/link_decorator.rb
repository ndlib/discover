class LinkDecorator < Draper::Decorator

  def self.factory(object)

  end

  def self.determine_class(object)
    LinkDecorator
  end

  def link
    h.link_to title, url, target: 'blank'
  end


  def notes
    return "" if object['notes'].nil?

    h.content_tag(:ul) do
      object['notes'].collect { | item | h.concat(h.content_tag(:li, h.raw(item))) }
    end
  end


  def title
    object['title']
  end


  def url
    object['url']
  end


end


class OpenURLDecorator < LinkDecorator


end


class PrimoKeyLinkDecorator < LinkDecorator

end
