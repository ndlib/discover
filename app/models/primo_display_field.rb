class PrimoDisplayField < ActiveRecord::Base
  validates :key, presence: true, uniqueness: true

  has_many :examples, class_name: "PrimoDisplayFieldExample", primary_key: :key, foreign_key: :key

  def self.log_unknown(key)
    key = key.to_s
    display_field = self.find_by_key(key)
    if display_field.nil?
      display_field = self.new(key: key)
      display_field.save
    end
    yield display_field if block_given?
    display_field
  end

  def add_example(record_id, body)
    example = examples.where(record_id: record_id).first
    if example.nil?
      example = examples.build(record_id: record_id, body: body)
      example.save
    end
    example
  end
end
