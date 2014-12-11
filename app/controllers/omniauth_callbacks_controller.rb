class OmniauthCallbacksController < ApplicationController

  # колбэк при успешном получении разрешений
  def vkontakte
    # Ищем пользователя или создаем нового
    p request.env['omniauth.auth']
    @user = User.find_for_vkontakte_oauth(request.env["omniauth.auth"])

    # если пользовтель создан без ошибок и уже сущесвует входим под ним и выводим приветственное сообщение
    if @user.errors.count==0 && @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      flash_msg(:notice, "Добро пожаловать #{current_user.first_name}",'Успешно вошли')if is_navigational_format?

    #   в противном случае выводим сообщение об ошибке и переходим на стартовую страницу
    else
      session["devise.data"] = request.env["omniauth.auth"]
      flash_msg :error, @user.errors.full_messages.first, 'Ошибка авторизации'
      redirect_to root_path
    end
  end

  # колбэк при ошибке. Обрабатываем сообщение, переходим на главную и выводим сообщение.
  def failure
    @err = Hash.new

    # получаем ошибку и ее описание из параметров
    @err[:title]=params[:error]
    @err[:msg]=params[:error_description]

    # заменяем текст ошибки и описания если пользователь запртил доступ приложения
    if @err[:title] == 'access_denied' && @err[:msg]=='User denied your request'
      @err[:title]='Вы заблокировали доступ к ВК'
      @err[:msg]='Доступ к ВК у нас обязателен'

    # если в параметрах не пришло ошибки, значит проблема на стороне приложения.
    #   заменяем сообщение и выводим
    elsif @err[:msg].nil?
      @err[:title]='Ошибка авторизации'
      @err[:msg]='Что то пошло не так :('
    end
    flash[:error]= @err
    redirect_to root_path
  end
end
