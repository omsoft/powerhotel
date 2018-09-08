class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :country_code
      t.float :average_price
      t.integer :views_count, default: 0

      t.timestamps null: false
    end

    reversible do |dir|
      dir.up do
        Hotel.create_translation_table! :description => :text
      end

      dir.down do
        Hotel.drop_translation_table!
      end
    end
  end
end
