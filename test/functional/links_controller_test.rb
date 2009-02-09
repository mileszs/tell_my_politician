require 'test_helper'

class LinksControllerTest < ActionController::TestCase


  def setup
    @controller = LinksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "on GET to :add" do
    setup { get :add, :link => { :url => 'http://google.com' } }
    should_assign_to :link
    should_assign_to :user
    should_render_template :add
    should_not_set_the_flash
    should_respond_with :success
  end

end
