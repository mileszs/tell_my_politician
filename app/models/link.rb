class Link < ActiveRecord::Base
  validates_presence_of :url

  has_many :user_links
end
