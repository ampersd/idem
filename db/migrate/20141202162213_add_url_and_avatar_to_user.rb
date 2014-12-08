class AddUrlAndAvatarToUser < ActiveRecord::Migration
  def change
    # добавляем пользователю поле url - ссылку нас профиль вк
    add_column :users, :url, :string

    # добавляем ползоватлею ссылку на аватар
    add_column :users, :avatar, :string

    # добавляем пользователю e-mail
    add_column :users,:email, :string
  end
end
