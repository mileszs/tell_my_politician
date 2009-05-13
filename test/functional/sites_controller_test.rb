require 'test_helper'

class SitesControllerTest < ActionController::TestCase

  context "on GET to :home" do
    setup { get :home }
    should_render_template :home
    should_not_set_the_flash
    should_respond_with :success
  end

  context "on GET to :privacy" do
    setup { get :privacy }
    should_render_template :privacy
    should_not_set_the_flash
    should_respond_with :success
  end

  context "on GET to :contact" do
    setup { get :contact }
    should_render_template :contact
    should_not_set_the_flash
    should_respond_with :success
  end

  context "on GET to :instructions" do
    setup { get :instructions }
    should_render_template :instructions
    should_not_set_the_flash
    should_respond_with :success
  end

  context "on GET to :bookmarklet" do
    setup { get :bookmarklet }
    should_render_template :bookmarklet
    should_not_set_the_flash
    should_respond_with :success
  end

  context "on GET to :sentcontact" do

    setup do 
      get :sentcontact, 
        :category => 'Press',
        :name     => 'Xzibit',
        :email    => 'x_to_tha_z_44@yahoo.com',
        :phone    => '8009999876',
        :subject  => 'Yo dawg!',
        :message  => 'You been pimped!'
    end

    should "send an email" do
      assert_sent_email
    end
  end
end
