class OnlineAccessDecorator < Draper::Decorator

  def self.find(id)
    record = DiscoveryQuery.find_by_id(id)
    self.new(record)
  end


  def title
    object.title
  end



end
