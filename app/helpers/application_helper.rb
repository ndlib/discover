module ApplicationHelper
  def ul_list(title, list, css_class = "")
    return "" if list.empty? || list.join.empty?

    ret = content_tag(:div, title)
    ret += content_tag(:ul, class: css_class) do
      list.each { |note| concat(content_tag(:li, note)) }
    end

    ret
  end

  def id_from_strings(*args)
    args.collect { |str| str.gsub(/[^0-9A-Za-z]/, '') }.join("-")
  end
end
