module ApplicationHelper
  # хелпер генерации flash нотификаций
  def flash_msg(level,msg,title=nil)
    flash[level]={'title'=>title, 'msg'=>msg}
  end
end
