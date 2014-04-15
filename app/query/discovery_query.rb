class DiscoveryQuery

  def find_by_id(id)
    DiscoveryRecord.new(HesburghAPI::Discovery.record(id))
  end

end
