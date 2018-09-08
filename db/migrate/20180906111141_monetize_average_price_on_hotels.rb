class MonetizeAveragePriceOnHotels < ActiveRecord::Migration
  def change
  	change_table :hotels do |t|
      t.monetize :average_price
    end

    remove_column :hotels, :average_price, :float
  end
end
