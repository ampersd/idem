class CreateCities < ActiveRecord::Migration
  def change
    # создаем таблицу
    create_table :cities do |t|
      # поле title - название города
      t.string :title, null: false
    end
  end
end
