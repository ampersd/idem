class CreateUsers < ActiveRecord::Migration
  def change
    # создаем таблицу пользователей
    create_table :users do |t|
      # Имя
      t.string :first_name, null:false
      # Фамилия
      t.string :last_name
      # токен ВК
      t.string :session_token, null:false
      t.timestamps
    end
    add_reference :users, :city, index:true
  end
end
