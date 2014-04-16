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

  def display_fields
    discovery_record.display_fields
  end

  def display_field(key)
    display_fields[key.to_s]
  end

  def display_field_keys
    display_fields.keys.collect{|key| key.to_sym}
  end

  def log_field(key)
    key = key.to_s
    display_field_record = PrimoDisplayField.find_or_initialize_by_key(key)
    if display_field_record.new_record?
      display_field_record.save
    end
    add_example(display_field_record)
    display_field_record
  end

  def add_example(display_field_record)
    example = display_field_record.example(record_id)
    if example.nil?
      example = display_field_record.examples.build(record_id: record_id, body: display_field(display_field_record.key))
      example.save
    end
    example
  end

  def record_id
    discovery_record.id
  end

  def log

  end
end
