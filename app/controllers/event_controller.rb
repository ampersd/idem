class EventController < ApplicationController

  # страница всех собыйтий
  def index
        #  выводим всем события для города пользователя
        @events = current_user.city.events
  end
end
