class HoldVolume

  attr_reader :data, :items

  def initialize(data)
    @data = data
    @items = []
  end

  def title
    get(:description)
  end

  def id
    get(:enumeration)
  end

  def sort_order
    get(:sort_order)
  end

  def single_volume?
    title == 'single_volume'
  end

  def add_items(new_items)
    @items += new_items
  end

  private
    def get(key)
      data[key.to_s]
    end
end
