class LinkDecorator < Draper::Decorator

  def self.factory(object)
    determine_class(object).new(object)
  end

  def self.determine_class(object)
    [ OpenURLDecorator, HathiTrustLinkDecorator ].each do | klass |
      return klass if klass.use_this_class?(object)
    end

    return LinkDecorator
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

  def self.use_this_class?(object)
    object['source'].downcase == 'openurl'
  end

end


class PrimoKeyLinkDecorator < LinkDecorator

end


class HathiTrustLinkDecorator < LinkDecorator

  def self.use_this_class?(object)
    object['title'] == 'linktorsrc_pub' && object['url'].match(/^http:\/\/catalog[.]hathitrust/)
  end
end
