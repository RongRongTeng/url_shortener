# frozen_string_literal: true

class CreateLinkCustoms < ActiveRecord::Migration[5.2]
  def change
    create_table :link_customs do |t|
      t.references :link,      null: false
      t.string  :short_path,   null: false
      t.integer :click_count,  null: false, default: 0

      t.timestamps
    end

    add_index :link_customs, :short_path, unique: true
  end
end
