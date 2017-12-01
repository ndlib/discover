module ApplicationHelper
  def ul_list(title, list, css_class = "")
    return "" if list.empty? || list.join.empty?

    ret = ""
    ret += content_tag(:h5, title) if title.present?
    ret += content_tag(:ul, class: css_class) do
      list.each { |note| concat(content_tag(:li, process_li(note))) }
    end

    ret.html_safe
  end

  def process_li(note)
    note
  end

  def id_from_strings(*args)
    args.collect { |str| str.gsub(/[^0-9A-Za-z]/, '') }.join("-")
  end

  def join_strings_safe(joiner, *args)
    args.keep_if { |s| s && s.length > 0 }.collect { |s| s.strip }.join(joiner)
  end

  def order_holdings_list(list)
    # order should be
    # current -> REF -> other libs -> HESB -> ANNEX

    # key defines
    lib = "library_code"
    notes = "notes"

    # library codes
    annex = "ANNEX"
    hesRef = "REF"
    hesGen = "HESB"

    # notes
    current = "Currently received."

    # sort return values
    equal = 0
    xPriority = -1
    yPriority = 1

    # sort the list
    list.sort do |xEntry, yEntry|
      x = xEntry[lib]
      y = yEntry[lib]

      xCurrent = xEntry[notes].include?(current)
      yCurrent = yEntry[notes].include?(current)

      if x == y
        equal
      elsif xCurrent
        xPriority
      elsif yCurrent
        yPriority
      elsif x == hesRef
        xPriority
      elsif y == hesRef
        yPriority
      elsif x == annex
        yPriority
      elsif y == annex
        xPriority
      elsif x == hesGen
        yPriority
      elsif y == hesGen
        xPriority
      else
        equal
      end
    end
  end
end
