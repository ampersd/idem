# Добавляем поддержку метода to_hashsum в Hashie::Mash
class Hashie::Mash
  def to_hashsum
      # возвращаем хэш объекта преобразованного в строку
      Digest::MD5.base64digest(self.to_s)
    end
end


