class App < ActiveRecord::Base
  scope :all, :order => 'name asc'

  validates_presence_of :name
  validates_url_format_of :homepage_url, :message => "is invalid"

  def self.featured
    self.random
  end
end
