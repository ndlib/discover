class HoldItem

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def institution_code
    get(:institution_code)
  end

  def pickup_locations
    get(:pickup_locations)
  end

  def description
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
end
