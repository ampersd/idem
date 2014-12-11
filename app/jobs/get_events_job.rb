# Описание задачи получения списка событий
class GetEvents
  @queue = :events

  def self.perform
    Resque.logger.resque_info "Начали обновление списка событий #{Time.now.to_s}"
    # выполняем серию запросов для каждого города
    City.all.each do |city|

      # создаем клиент для выполнения запросов с активным токеном
      vk = VkontakteApi::Client.new(city.users.with_active_token.first.session_token)

      # массив поисковых запросов
      l_arr=%w(А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ъ Ы Ь Э Ю Я A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

      # массив результатов
      @events = Array.new

      # выполняем поисковой запрос для каждого элемента из массива поисковых запросов
      while l_arr.size > 0 do
        l = l_arr.pop
        results = vk.groups.search(type:"event",q:l,future:"1",city_id:city.id)
        # Так как в секнду можно выполнить ограниченое количество запросов к API выставляем таймаут
        sleep 0.5

        # удаляем из результатов число(количество результатов)
        results.map{|e| results.delete(e) if e.class == Fixnum}
        @events |= results
      end
      @events.each do |event|

        # Задержка чтобы не привышать лимит запросов к API
        sleep 0.5
        Event.create_or_update event
      end

      Resque.logger.resque_info "Завершили обновление событий #{Time.now.to_s} - #{@events.length}"
      @events= nil
      vk=nil
    end
  end
end