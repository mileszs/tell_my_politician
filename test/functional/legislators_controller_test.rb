require 'test_helper'
require 'factory_girl'

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
    setup do
      legislators = {
        :senior_senator => new_legislator,
        :junior_senator => new_legislator,
        :representative => new_legislator
      }
      Legislator.stubs(:all_for).returns(legislators)
      get :index, :address => '1980 Picadilly Pl. Apt#A Indianapolis, IN 46260'
    end
    should_assign_to :results
    should_render_template :index
    should_not_set_the_flash
    should_respond_with :success
  end

  private

  def new_legislator(attrs = {})
    Legislator.new({
    'title' =>        'Sen',
    'firstname' =>    'Miles',
    'middlename' =>   'Zane',
    'lastname' =>     'Sterrett',
    'party' =>        'I',
    'state' =>        'IN',
    'district' =>     'Junior Seat',
    'in_office' =>    '1',
    'gender' =>       'M',
    'website' =>      'http://mileszs.com',
    'webform' =>      'http://mileszs.com',
    'email' =>        'miles.sterrett@gmail.com'
    }.merge(attrs))
  end

end
