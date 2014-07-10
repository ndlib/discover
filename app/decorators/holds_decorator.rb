class HoldsDecorator < Draper::Decorator

  def title
    object.title.first
  end

  def page_title
    title
  end


  def volumes

  end

end


class HoldsVolume

  def initialize(volume, items)
    @volume = volume
    @items = items
  end

  def id
    @volume[:enumeration]
  end


  def title
    @volume[:description]
  end


  def items

  end
end


class HoldsItem


end
