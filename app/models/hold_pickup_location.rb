class HoldPickupLocation

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def id
    get(:code)
  end

  def institution_code
    @institution_code ||= get(:code).gsub(/[^a-z]+.*$/i,'')
  end

  def title
    get(:content)
  end

  def get(key)
    data[key.to_s]
  end
  private :get
end
