class EventController < ApplicationController

  # страница всех собыйтий
  def index
    # Далее получение всех событий для текущего города пользователя.
    # Так как в VK.API поисковая строка является
    # обязательным параметром, то создаем массиф символов и по каждому из них выполняем  поисковой запрос,
    # в массив @events добавляем только уникальные элементы
    vk = VkontakteApi::Client.new(current_user.session_token)
    l_arr=["А","Б","В","Г","Д","Е","Ё","Ж","З","И","Й","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Щ","Ъ","Ы","Ь","Э","Ю","Я"]
    @events = Array.new
    while l_arr.size > 0 do
        l = l_arr.pop
        rr = vk.groups.search(type:"event",q:l,future:"1",city_id:current_user.city.id)
        # Так как в секнду можно выполнить ограниченое количество запросов к API выставляем таймаут
        sleep 0.1
      @events |= rr
      vk =nil
    end
      # Попытка вызвать хранимую процедуру на строне VK. Почему то возвращает массив 0.
      # @events= vk.execute.serB(city:current_user.city.id)
  #   todo так как процедура занимает много времени, ее стоит выполнять ассинхронно. Возможно стоит вынести в фоновую задачу.
  end
end
