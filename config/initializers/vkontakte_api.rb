#  создаем клиент для API чтобы использовать методы не требудщие авторизации.
# VkontakteApi.configure.log_responses= true
 VkontakteApi.configure do |config|
  config.logger = Logger.new('log/vk_api.log')
  config.log_requests = false
 end

$vk = VkontakteApi::Client.new