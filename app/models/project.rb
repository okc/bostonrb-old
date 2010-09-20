class Project < ActiveRecord::Base
  belongs_to :user

  scope :all, :order => 'name asc'

  validates_presence_of :name, :user_id
  validates_url_format_of :github_url, :message => "is invalid"

  def to_s
    name
  end

  def self.featured
    self.random
  end

  scope :all_except, lambda { |project|
    { :conditions => ['id <> ?', project],
      :order => 'name asc' }
  }
end
