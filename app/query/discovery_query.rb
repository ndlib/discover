class DiscoveryQuery

  def self.find_by_id(id, vid)
    self.new.find_by_id(id, vid)
  end

  def self.fullview(id, vid)
    self.new.fullview(id, vid)
  end

  def self.holds_list(id, patron_id, vid)
    self.new.holds_list(id, patron_id, vid)
  end

  def find_by_id(id, vid)
    DiscoveryRecord.new(HesburghAPI2::Discovery.record(id, vid), vid)
  end

  def fullview(id, vid)
    DiscoveryRecord.new(HesburghAPI2::Discovery.fullview(id, vid), vid)
  end

  def holds_list(id, patron_id, vid)
    DiscoveryRecord.new(HesburghAPI2::Discovery.holds_list(id, patron_id), vid)
  end

end
