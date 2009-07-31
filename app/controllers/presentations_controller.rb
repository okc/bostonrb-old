class PresentationsController < ResourceController::Base
  create.flash "Presentation created."
  create.wants.html  { redirect_to root_url }

  update.flash "Presentation updated."

  destroy.flash "Presentation deleted."
  destroy.wants.html { redirect_to root_url }
end
