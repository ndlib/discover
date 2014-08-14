class HoldData
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def single_volume?
    volumes.count == 1 && volumes.first.single_volume?
  end

  def volumes
    @volumes ||= [].tap do |array|
      get(:volumes).each do |volume_data|
        array.push build_volume(volume_data)
      end
    end
  end

  def build_volume(volume_data)
    HoldVolume.new(volume_data).tap do |volume|
      volume.add_items(items(volume.enumeration))
    end
  end

  def items_hash
    @items_hash ||= {}.tap do |hash|
      get(:items_by_enumeration).each do |items_data|
        hash[items_data["enumeration"]] = build_items(items_data["items"])
      end
    end
  end

  def items(volume_enumeration)
    items_hash[volume_enumeration.to_s] || []
  end

  def build_items(items_array)
    items_array.collect{ |item_data| HoldItem.new(item_data) }
  end

  def self.base_institution_code(aleph_institution_code)
    base_code = aleph_institution_code.gsub(/[^a-z]+.*$/i,'')
    if base_code == 'HESB'
      'NDU'
    else
      base_code
    end
  end

  def get(key)
    data[key.to_s]
  end
  private :get
end
