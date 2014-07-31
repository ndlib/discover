class HoldData
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def volumes
    @volumes ||= [].tap do |array|
      get(:volumes).each do |volume_data|
        array.push build_volume(volume_data)
      end
    end
  end

  def build_volume(volume_data)
    HoldVolume.new(volume_data)
  end

  def items_hash
    @items_hash ||= {}.tap do |hash|
      get(:items_by_enumeration).each do |items_data|
        hash[items_data["enumeration"]] = build_items(items_data["items"])
      end
    end
  end

  def items(enumeration)
    items_hash[enumeration.to_s]
  end

  def build_items(items_array)
    items_array.collect{ |item_data| HoldItem.new(item_data) }
  end

  def get(key)
    data[key.to_s]
  end
  private :get

end
