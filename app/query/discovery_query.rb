class DiscoveryQuery

  def self.find_by_id(id, vid)
    self.new.find_by_id(id, vid)
  end

  def self.fullview(id, vid)
    self.new.fullview(id, vid)
  end

  def find_by_id(id, vid)
    DiscoveryRecord.new(HesburghAPI2::Discovery.record(id, vid))
  end

  def fullview(id, vid)
    DiscoveryRecord.new(HesburghAPI2::Discovery.fullview(id, vid))
  end

end
