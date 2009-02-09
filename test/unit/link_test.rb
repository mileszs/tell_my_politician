require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  should_validate_presence_of :url
  should_have_many :user_links
end
