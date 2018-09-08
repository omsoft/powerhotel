class CreateHotelsUsers < ActiveRecord::Migration
  def change
    create_table :hotels_users, id: false do |t|
      t.belongs_to :hotel, index: true
      t.belongs_to :user, index: true
    end
  end
end
