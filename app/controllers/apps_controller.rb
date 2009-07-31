class AppsController < ResourceController::Base
  create.wants.html { redirect_to root_url }

  destroy.flash 'App deleted.'
  destroy.wants.html { redirect_to root_url }


end
