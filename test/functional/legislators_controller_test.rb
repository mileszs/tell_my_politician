require 'test_helper'
require 'factory_girl'

class LegislatorsControllerTest < ActionController::TestCase

  def setup
    @controller = LegislatorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "on GET to :search" do

    context "without a cookie for ZIP code" do
      setup do
        get :search, :u => 'http://google.com', :title => 'some title'
      end
      should_assign_to :link
      should_render_template :search
      should_not_set_the_flash
      should_respond_with :success
    end

    context "with a cookie for ZIP code" do
      setup do
        @request.cookies['zip'] = CGI::Cookie.new('name' => 'zip', 'value' => '46260')
        get :search, :u => 'http://google.com', :title => 'some title'
      end
      should_assign_to :link
      should_not_set_the_flash
      should_redirect_to("legislators_url(:u => 'http://google.com')") { legislators_url(:u => 'http://google.com') }
    end
  end

  context "on GET to :bm_search" do

    context "without a cookie for ZIP code" do
      setup { get :bm_search, :u => 'http://google.com', :title => 'some title' }
      should_assign_to :link
      should_not_set_the_flash
      should_respond_with :success
      should_render_with_layout :bookmarklet
    end

    context "with a cookie for ZIP code" do
      setup do
        @request.cookies['zip'] = CGI::Cookie.new('name' => 'zip', 'value' => '46260')
        get :bm_search, :u => 'http://google.com', :title => 'some title'
      end
      should_assign_to :link
      should_not_set_the_flash
      should_redirect_to("bm_legislators_url(:u => 'http://google.com')") { bm_legislators_url(:u => 'http://google.com') }
    end
  end

  context "on GET to :index" do

    setup do
      legislators = {
        :senior_senator => new_legislator,
        :junior_senator => new_legislator,
        :representative => new_legislator
      }
      Sunlight::Legislator.stubs(:all_for).returns(legislators)
      get :index, :address => '1980 Picadilly Pl. Apt#A Indianapolis, IN 46260'
    end

    context "without a cookie for ZIP code, latitude, or longitude set" do
      should "have a blank 'zip' cookie" do
        assert @request.cookies['zip'].blank?
      end
      should "have a blank 'lat' cookie" do
        assert @request.cookies['lat'].blank?
      end
      should "have a blank 'long' cookie" do
        assert @request.cookies['long'].blank?
      end
      should_assign_to :results
      should_render_template :index
      should_not_set_the_flash
      should_respond_with :success
    end

    context "with a cookie for ZIP code, latitude, and longitude set" do
      setup do
        @request.cookies['zip'] = CGI::Cookie.new('name' => 'zip', 'value' => '46260')
        @request.cookies['lat'] = CGI::Cookie.new('name' => 'latitude', 'value' => '39.9209164')
        @request.cookies['long'] = CGI::Cookie.new('name' => 'zip', 'value' => '-86.1945985')
      end

      should "not have a blank 'zip' cookie" do
        assert !@request.cookies['zip'].blank?
      end
      should "not have a blank 'lat' cookie" do
        assert !@request.cookies['lat'].blank?
      end
      should "not have a blank 'long' cookie" do
        assert !@request.cookies['long'].blank?
      end
      should_assign_to :results
      should_render_template :index
      should_not_set_the_flash
      should_respond_with :success

    end
  end

  context "on GET to :bm_index" do

    setup do
      legislators = {
        :senior_senator => new_legislator,
        :junior_senator => new_legislator,
        :representative => new_legislator
      }
      Sunlight::Legislator.stubs(:all_for).returns(legislators)
      get :bm_index, :address => '1980 Picadilly Pl. Apt#A Indianapolis, IN 46260'
    end

    context "without a cookie for ZIP code, latitude, or longitude set" do
      should "have a blank 'zip' cookie" do
        assert @request.cookies['zip'].blank?
      end
      should "have a blank 'lat' cookie" do
        assert @request.cookies['lat'].blank?
      end
      should "have a blank 'long' cookie" do
        assert @request.cookies['long'].blank?
      end
      should_assign_to :results
      should_render_template :bm_index
      should_not_set_the_flash
      should_respond_with :success
      should_render_with_layout :bookmarklet
    end

    context "with a cookie for ZIP code, latitude, and longitude set" do
      setup do
        @request.cookies['zip'] = CGI::Cookie.new('name' => 'zip', 'value' => '46260')
        @request.cookies['lat'] = CGI::Cookie.new('name' => 'latitude', 'value' => '39.9209164')
        @request.cookies['long'] = CGI::Cookie.new('name' => 'zip', 'value' => '-86.1945985')
      end

      should "not have a blank 'zip' cookie" do
        assert !@request.cookies['zip'].blank?
      end
      should "not have a blank 'lat' cookie" do
        assert !@request.cookies['lat'].blank?
      end
      should "not have a blank 'long' cookie" do
        assert !@request.cookies['long'].blank?
      end
      should_assign_to :results
      should_render_template :bm_index
      should_not_set_the_flash
      should_respond_with :success
      should_render_with_layout :bookmarklet
    end
  end

  private

  def new_legislator(attrs = {})
    Sunlight::Legislator.new({
    'title'       => 'Sen',
    'firstname'   => 'Miles',
    'middlename'  => 'Zane',
    'lastname'    => 'Sterrett',
    'party'       => 'I',
    'state'       => 'IN',
    'district'    => 'Junior Seat',
    'in_office'   => '1',
    'gender'      => 'M',
    'website'     => 'http://mileszs.com',
    'webform'     => 'http://mileszs.com',
    'email'       => 'miles.sterrett@gmail.com',
    'bioguide_id' => '8',
    'twitter_id'  => ''
    }.merge(attrs))
  end

end
