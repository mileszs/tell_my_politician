require 'test_helper'

class ToolbarControllerTest < ActionController::TestCase

  def setup
    @controller = ToolbarController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "on GET to :index with cookie set" do
      setup do
        @request.cookies['zip'] = '46260'
        get :index, :u => 'http://google.com', :target_url => 'http://gmail.com' 
      end
      should_assign_to :original_url
      should_assign_to :search_url
      should_assign_to :target_url
      should_render_template :index
      should_not_set_the_flash
      should_respond_with :success
    end
end
