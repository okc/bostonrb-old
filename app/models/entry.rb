class Entry < ActiveRecord::Base
  include Pacecar
#!error - remove ::Entry
#  include Feedra
#  include Feedra::Entry

  def self.recent(limit)
    limited(limit).by_published_at(:desc).by_created_at(:desc)
  end
  
end
