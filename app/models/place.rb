class Place < ActiveRecord::Base
  belongs_to :city, inverse_of: :places
  has_many :events

  # создает или возвращает уже созданное место
  def self.find_or_create(hashie)
    # если место уже есть то возвращаем его
    if place = self.where(id: hashie.pid).first
      place

    # если месата нет, создаем его
    else

      key_map={
          pid: :id,
          latitude: :la,
          longitude: :lo,
      }
      bad_keys=%w(country created group_id group_photo type updated)
      # присваиваем полю city город из модели City
      hashie.city = City.find_or_create(hashie.city)

      # ремапим ключи и удаляем неиспользуемые
      hashie.key_remap!(key_map)
      hashie.clear!(bad_keys)

      # создаем место
      Place.create hashie.to_hash
    end
  end
end
