class PrimoDisplayField < ActiveRecord::Base
  validates :key, presence: true, uniqueness: true

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
end
