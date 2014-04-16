class PrimoDisplayFieldExample < ActiveRecord::Base
  belongs_to :display_field, class_name: "PrimoDisplayField", primary_key: :key, foreign_key: :key
  serialize :body
end
