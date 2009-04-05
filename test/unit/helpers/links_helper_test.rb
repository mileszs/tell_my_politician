require File.dirname(__FILE__) + '/../../test_helper'
class LinksHelperTest < ActionView::TestCase

  context "on :legislator_image" do
    should "return an image tag when passed a non-existant file name" do
      output = legislator_image('8')
      assert output =~ /<img/
    end

    context "when passed an existing file name" do
      setup do
        f = Dir.entries("#{Rails.root}/public/images/pictures")[2]
        @output = legislator_image(f.split('.')[0])
      end

      should "return an image tag" do
        assert @output =~ /<img/
      end

      should "not show a filler image if passed an existing id" do
        assert @output !=~ /filler-image/
      end
    end
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

  context "on :full_address" do
    should "return the string of 20515 for the Cannon,Longworth,Rayburn Office Building" do

        zip = '20515'

	output = full_address( 'Cannon' )
        assert output.include? zip
        
        output = full_address( 'Longworth')
        assert output.include? zip

        output = full_address( 'Rayburn')
        assert output.include? zip

    end
    
    should "return the string 21510 for the Russell, Hart, Dirksen Office Building" do

        zip = '20510'

	output = full_address('Russell')
        assert output.include? zip

        output = full_address('Hart')
        assert output.include? zip

        output = full_address('Dirksen')
        assert output.include? zip

    end

    should "return a address with zip code 21510 for other addresses" do

        output = full_address( 'testtesttest' )
        assert output.include? '20510'

    end

  end

end
