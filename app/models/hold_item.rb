class HoldItem

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def id
    item_id
  end

  def institution_code
    get(:institution_code)
  end

  def institution_title
    if primary_location.present?
      primary_location.title
    else
      institution_code
    end
  end

  def pickup_locations
    @pickup_locations ||= build_pickup_locations
  end

  def primary_location
    pickup_locations.detect { |location| location.id == institution_code }
  end

  def title
    get(:description)
  end

  def bib_id
    get(:bib_id)
  end

  def item_id
    get(:item_id)
  end

  def status_message
    get(:status_message)
  end

  def location
    get(:location)
  end

  def get(key)
    data[key.to_s]
  end
  private :get

  def build_pickup_locations
    get(:pickup_locations).collect { |location_data| HoldPickupLocation.new(location_data) }
  end
  private :build_pickup_locations
end
