class EventsController < ResourceController::Base

  def index
    respond_to do |wants|
      wants.html { @events = Event.next(4) }
      wants.atom { @events = Event.next(10) }
      wants.rss { 
        @new_feed_url = request.url.gsub!("rss", "atom")
        @message = "Please use our Atom feed instead:<br />" +
        "<a href='#{@new_feed_url}'>#{@new_feed_url}</a>" 
      }
    end
  end

  create.flash 'Event created.'
  create.wants.html { redirect_to root_url }

  update.flash 'Event updated.'

  destroy.flash 'Event deleted.'
  destroy.wants.html { redirect_to root_url }

end
