class DiscoveryQuery

  def self.find_by_id(id)
    self.new.find_by_id(id)
  end


  def find_by_id(id)
    DiscoveryRecord.new(HesburghAPI::Discovery.record(id))
  end

end
