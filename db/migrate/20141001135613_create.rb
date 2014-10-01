class Create < ActiveRecord::Migration
  def change

    create_table :stats_sources do | t |
      t.string :primo_id
      t.string :source
    end

    add_index :stats_sources, :primo_id

    create_table :stats_link_clicks do | t |
      t.string :fulltext_title
      t.integer :stats_source_id
      t.datetime :created_at
    end

    add_index :stats_link_clicks, :stats_source_id
  end
end
