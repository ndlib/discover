class HoldVolume

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def description
    get(:description)
  end

  def enumeration
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
