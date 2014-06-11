class DiscoveryQuery

  def self.find_by_id(id)
    self.new.find_by_id(id)
  end

  def self.fullview(id)
    self.new.fullview(id)
  end

  def find_by_id(id)
    DiscoveryRecord.new(HesburghAPI2::Discovery.record(id))
  end

  def fullview(id)
    DiscoveryRecord.new(HesburghAPI2::Discovery.fullview(id))
  end

end
