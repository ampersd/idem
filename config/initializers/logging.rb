# Уровни логирования
Logging.init :debug, :info, :resque_info, :warn, :success, :error, :fatal

# создаем логер для resque
$resque_loger = Logging.logger['resque']

# Добавляем форматы
$resque_loger.add_appenders(
    # вывод в файл
    Logging.appenders.rolling_file(
        'log/resque.log',
        :age    => 'daily',
        :layout => Logging.layouts.pattern(:pattern => '%.1l, [%d] %5l -- %c: %m\n')),
    # вывод в консоль
    Logging.appenders.stdout(
        :layout => Logging.layouts.pattern(:pattern => '%.1l, [%d] %5l -- %c: %m\n'))
)

# фильтруем все что ниже :resque_info
$resque_loger.level = :resque_info