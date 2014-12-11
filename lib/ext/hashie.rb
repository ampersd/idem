# Добавляем поддержку методов to_hashsum, key_remap!, clear! в Hashie::Mash
class Hashie::Mash
  def to_hashsum
      # возвращаем хэш объекта преобразованного в строку
      Digest::MD5.base64digest(self.to_s)
  end

  # заменяеьт ключ из хэша ремапа
  # хэш должен быть в формате
  # {old_key: :new_key, old_key2: :new_key2}
  def key_remap!(key_map)
    key_map.each{|old,new| self[new] = self.delete old}
  end

  # удаляет значения которые не нужны
  def clear!(array_of_keys)
    array_of_keys.each do |bk|
      self.delete(bk.to_sym)
    end
  end
end


