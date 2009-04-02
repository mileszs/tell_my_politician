require File.dirname(__FILE__) + '/../../test_helper'
class LinksHelperTest < ActionView::TestCase

  should "return an image tag on :legislator_image" do
    output = legislator_image('8')
    assert output =~ /<img/
  end

  should "return an anchor tag on :contact_link" do
    output = contact_link('Sen', 'Miles', 'Sterrett', 'miles@tellmypolitician.com', 'http://google.com', 'http://cnn.com')
    assert output =~ /<a/
  end

  should "return an anchor tag on :website_link" do
    output = website_link('http://google.com', 'Sen', 'miles', 'sterrett')
    assert output =~ /<a/
  end

  should "return an anchor tag on :twitter_link" do
    output = twitter_link('mileszs', 'title', 'miles', 'sterrett')
    assert output =~ /<a/
  end

  context "on :full_party_name" do

    should "return a string representing democrats when passed 'D'" do
      output = full_party_name('D')
      assert output =~ /democrat/i
    end

    should "return a string representing republicans when passed 'R'" do
      output = full_party_name('R')
      assert output =~ /republican/i
    end

    should "return a string representing independents when passed 'I'" do
      output = full_party_name('I')
      assert output =~ /independent/i
    end

  end

  context "on :full_title" do

    should "return 'Representative' when passed 'Rep'" do
      output = full_title('Rep')
      assert output == 'Representative'
    end

    should "return 'Senator' when passed 'Sen'" do
      output = full_title('Sen')
      assert output == 'Senator'
    end
  end

  context "on :email_link" do

    should "return the path to the toolbar if webform is not NONE" do
      output = email_link('miles@tellmypolitician.com', 'http://google.com')
      assert output =~ /\/toolbar\?/
    end

    should "return a mailto string if webform is NONE" do
      output = email_link('miles@tellmypolitician.com', 'NONE')
      assert output =~ /mailto:/
    end
  end

  context "on :district_or_seniority" do

    should "return string denoting district if passed a number as a string" do
      output = district_or_seniority('5')
      assert output =~ /District/i
      assert output =~ /#{output}/
    end

    should "return the string if it's not numerical" do
      output = district_or_seniority('Junior')
      assert output == output
    end
  end

  should "provide javascript to set the location of the top frame to the given URL on :topify" do
    output = topify('http://google.com')
    assert output =~ /window\.top\.location/
  end

end
