namespace :redis do
  desc "Запускаем Redis сервер"
  task :start do
    system "redis-server"
  end
end
