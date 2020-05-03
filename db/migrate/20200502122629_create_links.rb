# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.text    :original_url, null: false
      t.string  :short_path,   null: false
      t.integer :click_count,  null: false, default: 0

      t.timestamps
    end

    add_index :links, :original_url, unique: true
    add_index :links, :short_path, unique: true
  end
end
