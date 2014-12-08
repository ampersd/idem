class AddExpiration < ActiveRecord::Migration
  def change
    # добавляем пользователю поле expiration - когда истекает токен
    add_column :users, :expiration, :integer
  end
end
