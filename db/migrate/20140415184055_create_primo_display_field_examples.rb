class CreatePrimoDisplayFieldExamples < ActiveRecord::Migration
  def change
    create_table :primo_display_field_examples do |t|
      t.string :key
      t.string :record_id
      t.text   :body
      t.timestamps
    end

    add_index :primo_display_field_examples, :key
    add_index :primo_display_field_examples, :record_id
  end
end
