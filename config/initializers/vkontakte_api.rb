#  создаем клиент для API чтобы использовать методы не требудщие авторизации.
VkontakteApi.configure.log_responses= true
$vk = VkontakteApi::Client.new