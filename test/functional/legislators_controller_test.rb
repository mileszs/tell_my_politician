require 'test_helper'

class LegislatorsControllerTest < ActionController::TestCase


  def setup
    @controller = LegislatorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "on GET to :search" do
    setup { get :search, :link => { :url => 'http://google.com' } }
    should_assign_to :link
    should_assign_to :user
    should_render_template :search
    should_not_set_the_flash
    should_respond_with :success
  end

  context "on GET to :index" do
    #TODO: Should mock the call to the Sunlight API
    setup { get :index, :address => '1980 Picadilly Pl. Apt#A Indianapolis, IN 46260' }
    should_assign_to :results
    should_render_template :index
    should_not_set_the_flash
    should_respond_with :success
  end

end
