class User < ActiveRecord::Base
  # настраиваем devise для пользователя
  devise :registerable, :omniauthable,
         :rememberable, :trackable, :timeoutable

  # пользователь принадлежит городу
  belongs_to :city, inverse_of: :users

  # валидация полей город, имя и токен сессии
  validates :city, presence: {message:'^Не указан город'}
  validates :first_name, presence: {message:'^Имя у нас обязательно'}
  validates :session_token, presence: {message:'^Попробуйте еще раз'},uniqueness: {message:'^Ошибка получения токена'}

  # скоуп пользователей токен который активен
  scope :with_active_token, ->{where "expiration > ? OR expiration = 0", Time.now.to_i  }

  # # устанваливаем длительость сесии до длительности токена
    def timeout_in
      if self.expiration == 0
        1.year
      else
        self.expiration
      end
    end

  # создаем или получаем уже созданного пользователя
  def self.find_for_vkontakte_oauth access_token

    # если пользователь уже существует, обновлем его токен, время последнего входа, время активности токена и возвращаем пользователя
    # todo проверить присваивается ли 0
    if user = User.where(:id => access_token.uid).first
      user.update_attributes(session_token:access_token.credentials.token,last_sign_in_at:Time.now,expiration:(access_token.credentials.expires_at<=Time.now.to_i ? 0 : access_token.credentials.expires_at))
      user

    #   если пользователя нет создаем новгого из параметров пришедших вместе с токеном
    else
      user = User.new(:id => access_token.uid,
                      :url => access_token.info.urls.Vkontakte,
                      :first_name => access_token.info.first_name,
                      :last_name => access_token.info.last_name,
                      :avatar=> access_token.extra.raw_info.photo_50,
                      :city=>City.find_or_create(access_token.extra.raw_info.city),
                      :session_token=>access_token.credentials.token,
                      :expiration=>access_token.credentials.expires_at)
      user.save
      user
    end
  end
end
