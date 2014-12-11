# настраиваем подключение к Redis
uri = URI.parse("redis://localhost:6379/")
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

# подключаем планировщик
require 'resque-scheduler'
require 'resque/scheduler/server'

# Загружаем расписание
Resque.schedule = YAML.load_file("#{Rails.root}/config/rescue_schedule.yml")

# Подгружаем все джобы из папки app/jobs
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

# настраиваем логер
Resque.logger = $resque_loger