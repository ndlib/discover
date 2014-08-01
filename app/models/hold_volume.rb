class HoldVolume

  attr_reader :data

  def initialize(data)
    @data = data
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

  private
    def get(key)
      data[key.to_s]
    end
end
