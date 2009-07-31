class AppsController < ResourceController::Base

  create.flash 'App created.'
  create.wants.html { redirect_to root_url }

  update.flash 'App updated.'

  destroy.flash 'App deleted.'
  destroy.wants.html { redirect_to root_url }

end
