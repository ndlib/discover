module ApplicationHelper

  def ul_list(title, list)
    return "" if list.empty?

    ret = content_tag(:h5, title)
    ret += content_tag(:ul) do
      list.each { | note | concat(content_tag(:li, note)) }
    end

    ret
  end
end
