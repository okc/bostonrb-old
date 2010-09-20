class HomeController < ApplicationController

  def index
    @recurring_events      = Event.next(4).recurring
    @special_events        = Event.next(5).special

#    @users                 = User.ordered("updated_at desc")
    @users                 = User.order("updated_at desc")

    @recent_tweets         = Tweet.recent(5)
    @recent_blogs          = Entry.recent(10)

    @featured_project      = Project.featured
    @popular_projects      = Project.order("watchers desc").limit(5)

    @featured_job          = Job.featured
    @recent_jobs           = Job.order.limit(5)

    @recent_companies      = Company.order.limit(5)

    @featured_presentation = Presentation.featured
    @recent_presentations  = Presentation.order.limit(5)
  end

end
