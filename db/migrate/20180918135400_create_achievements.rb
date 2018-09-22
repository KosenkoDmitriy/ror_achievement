# frozen_string_literal: true

class CreateAchievements < ActiveRecord::Migration[5.2]
  def up
    create_table :achievements do |t|
      t.string :title
      t.text :description
      t.integer :privacy
      t.boolean :featured
      t.string :cover_image

      t.timestamps
    end
  end
  def down
    drop_table :achievements
  end
end
