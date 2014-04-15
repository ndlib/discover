class CreatePrimoDisplayFields < ActiveRecord::Migration
  def change
    create_table :primo_display_fields do |t|
      t.string :key
      t.timestamps
    end

    add_index :primo_display_fields, :key
  end
end
