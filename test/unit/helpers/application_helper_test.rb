require File.dirname(__FILE__) + '/../../test_helper'
class ApplicationHelperTest < ActionView::TestCase

  should "call content_for with section title on :title" do
    assert expects(:content_for).with(:title)
    title('testing')
  end

  should "call content_for for section meta_description on :meta_description" do
    assert expects(:content_for).with(:meta_description)
    meta_description('testing')
  end


  context "getting css class for the body" do
    setup do
      self.stubs(:controller).returns(LegislatorsController.new)
    end

    should "return a string including controller name on :body_class" do
      assert body_class =~ /legislators/
    end
  end

end
