class Event < ActiveRecord::Base
  has_one :place
  has_one :city

  # Метод создает новое событие если его нет, или же обновляет существующее если его данные изменились.
  def self.create_or_update(event_from_search)

    # получаем расширеную информацию о событии
    hashie = $vk.groups.get_by_id(group_id:event_from_search.gid,fields:'city,place,description,start_date,finish_date,status').first

    # удяляем статус если в статусе аудио запись, для того чтобы постоянно не обновлять событие
    if hashie.status_audio?
      hashie.status=nil
    end

    # удаляем ненужные ключи is_closed, type, is_admin, is_member
    bad_keys = %w(is_closed type is_admin is_member status_audio)
    bad_keys.each do |bk|
      hashie.delete(bk.to_sym)
    end

    # присваиваем месту ID места todo заменить на метод find_or_create модели Place
    if hashie.place?
      hashie.place_id = hashie.place.pid
      hashie.delete(:place)
    end


    # нормализуем хэш, заменя ключи API ключами модели
    key_map= {
        gid: :id,
        name: :title,
        city: :city_id,
        start_date: :start,
        finish_date: :finish,
        photo: :photo_small,
        photo_medium: :photo
    }
    key_map.each{|old,new| hashie[new] = hashie.delete old}

    # форматируем время
    hashie.start = Time.at hashie.start.to_i
    if hashie.finish?
      hashie.finish = Time.at hashie.finish.to_i
    end

    #   проверяем есть ли событие, если нет, создаем новое
    event = self.where(id:hashie.id).first
    if event.nil?
      hashie.event_hash = hashie.to_hashsum

      # добавляем запись в лог
      $resque_loger.resque_info "Добавили событие [#{hashie.id}]#{hashie.title}"
      self.create(hashie.to_hash)

    # если событие есть, сверяем хэши. если не совпадают, обновляем запись
    else
      if event.event_hash != hashie.to_hashsum

        # добавляем запись в лог
        $resque_loger.resque_info "Событие [#{event.id}]#{event.title} изменилось"

        # обновляем хэш
        hashie.event_hash = hashie.to_hashsum
        event.update_attributes hashie.to_hash
      end
    end
  end
end
