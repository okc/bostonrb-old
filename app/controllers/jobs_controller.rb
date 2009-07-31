class JobsController < ResourceController::Base

  before_filter :authorize, :only => [:edit]

  create.flash 'Job created.'
  create.wants.html { redirect_to root_url }

  update.flash 'Job updated.'

  destroy.flash 'Job deleted.'
  destroy.wants.html { redirect_to root_url }

  private

  def authorize
    unless user_session.edit_job? Job.find(params[:id])
      flash[:notice] = 'Editing time expired.'
      redirect_to root_path
    end
  end

end
