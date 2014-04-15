class LogUnknownDisplayFields
  KNOWN_FIELDS = [
    :title,
    :creator
  ]

  def self.call(discovery_record)
    self.new(discovery_record).log
  end

  def self.known_fields
    KNOWN_FIELDS
  end

  attr_reader :discovery_record

  def initialize(discovery_record)
    @discovery_record = discovery_record
  end

  def unknown_fields
    display_field_keys - self.class.known_fields
  end

  def display_field_keys
    discovery_record.display_fields.keys.collect{|key| key.to_sym}
  end

  def log_field(key)
    key = key.to_s
    display_field = PrimoDisplayField.find_or_initialize_by_key(key)
    if display_field.new_record?
      display_field.save
    end
    add_example(display_field)
    display_field
  end

  def add_example(display_field)

  end

  def log

  end
end
