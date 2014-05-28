class LogUnknownDisplayFields
  KNOWN_FIELDS = [
    :availinstitution,
    :availlibrary,
    :availpnx,
    :contributor,
    :creationdate,
    :creator,
    :format,
    :edition,
    :identifier,
    :language,
    :lds01,
    :lds02,
    :lds03,
    :lds06,  # not used
    :lds07,  # not used
    :lds30,
    :lds31,
    :relation,
    :publisher,
    :relation,
    :subject,
    :title,
    :type,
    :source,
    :description,
    :unititle,
    :version
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
    display_field_record = PrimoDisplayField.find_or_initialize_by(key: key)
    if display_field_record.new_record?
      display_field_record.save
      #email this puppy!!
      NotifyOfNewPrimoKey.new_primo_key(display_field_record).deliver
    end
    add_example(display_field_record)
    display_field_record
  end

  def add_example(display_field_record)
    example = display_field_record.examples.where(record_id: record_id).first
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
    unknown_fields.each do |key|
      log_field(key)
    end
  end
end
