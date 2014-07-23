class HoldsDecorator < Draper::Decorator

  def title
    object.title.first
  end


  def volumes

  end

end
