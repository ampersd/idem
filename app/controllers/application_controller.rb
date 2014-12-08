class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # подключаем хелперы
  include ApplicationHelper

  # переопределяем путь на который редиректить после входа
  def after_sign_in_path_for(user)
    home_path
  end

end
