Then /^(?:|I )should see a link within "([^\"]*)" to (.+)$/ do |selector, text|
  within(selector) do |content|
   assert_have_xpath("//a[@href='#{path_to(text)}']")
  end
end

Then /^(?:|I )should see a link to (.+)$/ do |text|
  assert_have_xpath("//a[@href='#{path_to(text)}']")
end

Then /^(?:|I )should see a "([^\"]*)" tag with its "([^\"]*)" attribute set to "([^\"]*)"$/ do |tagName, attrName, valName|
  assert_have_xpath("//#{tagName}[@#{attrName}='#{valName}']")
end
