class UserLink < ActiveRecord::Base
  validates_presence_of :ip

  belongs_to :link
end
