class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :title
      t.string :la
      t.string :lo
      t.string :icon
      t.integer :checkins
      t.string :address
    end
      add_reference :places, :city, index: true
  end
end
