class City < ActiveRecord::Base
  # имеет много пользователей
  has_many :users
  has_many :places
  has_many :events

  # валидация поля id. Должно присутствовать обязательно
  validates :id, presence: {message:"^Ошибка при создании города. Отсутствует ID."}
  # валидация поля title. Должно пристутствовать обязательно
  validates :title, presence: {message:"^Ошибка при создании города. Отсутсвует название города."}

  # метод ищет город, если не находит, то создает новый
  def self.find_or_create(id)

    # ищем город если есть возвращаем
    if city  = City.where(id:id).first
      city

    # если город не найден, выполняем запрос к VK.API и
    # получаем город по id. Создаем новую запись.
    # Если валидации прошли и удалось сохранить, возвращаем
    # город, если нет nil
    else
     vk_city = $vk.database.getCitiesById(city_ids:id).first
      city = City.new id:vk_city.cid,title:vk_city.name
      if city.save
        city
      else
        nil
      end
    end
  end
end
