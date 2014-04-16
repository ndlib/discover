class PrimoDisplayField < ActiveRecord::Base
  validates :key, presence: true, uniqueness: true

  has_many :examples, class_name: "PrimoDisplayFieldExample", primary_key: :key, foreign_key: :key
end
