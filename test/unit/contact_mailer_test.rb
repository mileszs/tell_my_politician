require File.dirname(__FILE__) + '/../test_helper'
class ContactMailerTest < Test::Unit::TestCase
  CHARSET = "utf-8"

  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @press_address   = 'press@tellmypolitician.com'
    @support_address = 'support@tellmypolitician.com'
    @info_address    = 'info@tellmypolitician.com'
  end

  context "contact email" do

    context "when the category is 'Press'" do
      setup do
        @category   = 'Press'
        @name       = 'Xzibit'
        @subject    = 'Yo dawg!'
        @email      = 'foo@bar.com'
        @phone      = '7655437995'
        @message    = 'We put a Republican IN YOUR DEMOCRAT!'
        @mail       = ContactMailer.create_contact(@category, @name, @email, @phone, @subject, @message)
      end

      should "send to the press email address" do
        assert @press_address =~ /#{@mail.to}/
      end

      should "include the category in the subject" do
        assert @mail.subject =~ /#{@category}/
      end
    end

    context "when the category is 'Technical Support'" do
      setup do
        @category   = 'Technical Support'
        @name       = 'Xzibit'
        @subject    = 'Yo dawg!'
        @email      = 'foo@bar.com'
        @phone      = '7655437995'
        @message    = 'We put a Republican IN YOUR DEMOCRAT!'
        @mail       = ContactMailer.create_contact(@category, @name, @email, @phone, @subject, @message)
      end

      should "send to the press email address" do
        assert @support_address =~ /#{@mail.to}/
      end

      should "include the category in the subject" do
        assert @mail.subject =~ /#{@category}/
      end
    end

    context "when the category is not Technical Support or Press" do
      setup do
        @category   = 'Different'
        @name       = 'Xzibit'
        @subject    = 'Yo dawg!'
        @email      = 'foo@bar.com'
        @phone      = '7655437995'
        @message    = 'We put a Republican IN YOUR DEMOCRAT!'
        @mail       = ContactMailer.create_contact(@category, @name, @email, @phone, @subject, @message)
      end

      should "send to the press email address" do
        assert @info_address =~ /#{@mail.to}/
      end

      should "include the category in the subject" do
        assert @mail.subject =~ /#{@category}/
      end
    end

    # should "bcc the given recipients" do 
    #   assert @recipients =~ /#{@email.bcc}/
    # end

    # should "bcc nFrame Staff" do
    #   assert 'nFrameStaff@nframe.com' =~ /#{@email.bcc}/
    # end
  end
end
