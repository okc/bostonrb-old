class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

# remove per http://www.madcowley.com/madcode/2010/02/upgrading-hoptoad-uninitialized-constant-hoptoadnotifiercatcher/
#  include HoptoadNotifier::Catcher
  include Clearance::Authentication

  before_filter :authenticate,
    :only => [:new, :create, :edit, :update, :destroy]

  protected

  def user_session
    @user_session ||= UserSession.new(session)
  end
  helper_method :user_session
end
