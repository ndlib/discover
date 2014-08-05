class HoldItem

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def id
    item_id_array.last
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

  def encrypted_item_id
    self.class.encrypt_item_id(item_id)
  end

  def item_id_array
    @item_id_array ||= item_id.split('$$$')
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

  def self.encrypt_item_id(item_id)
    crypt.encrypt_and_sign(item_id)
  end

  def self.decrypt_item_id(encrypted_item_id)
    crypt.decrypt_and_verify(encrypted_item_id)
  end

  def self.crypt
    ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
  end
end
