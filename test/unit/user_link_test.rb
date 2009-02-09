require 'test_helper'

class UserLinkTest < ActiveSupport::TestCase
  should_validate_presence_of :ip
  should_belong_to :link
end
