class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :screen_name
      t.string :photo_small
      t.string :photo
      t.string :photo_big
      t.timestamp :start
      t.timestamp :finish
      t.text :status
      t.text :description
      t.string :event_hash
    end
    add_reference :events, :place, index: true
    add_reference :events, :city, index: true
  end
end
