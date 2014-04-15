class LogUnknownDisplayFields

  def self.call(discovery_record)
    self.new(discovery_record).log
  end

  attr_reader :discovery_record

  def initialize(discovery_record)
    @discovery_record = discovery_record
  end

  def log

  end
end
