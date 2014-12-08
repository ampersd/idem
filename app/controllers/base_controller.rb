class BaseController < ApplicationController

  # пользователь должен быть залогинен, за исключением экшина start
  before_filter :authenticate_user!, except: :start

  # главная страница если поьзователь залогинен
  def home
    # возвращаем текущенго пользователя
    @user = current_user
  end

  # главная страница если пользователь не залогинен
  def start

    # если пользовтаель уже вошел, редиректим на home
    if user_signed_in?
      redirect_to home_path
    end
  end
end