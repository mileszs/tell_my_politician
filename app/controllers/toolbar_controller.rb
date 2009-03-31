class ToolbarController < ApplicationController
  def index
    #the original_url was the page that they were on that they are passing to the legislator
    @original_url = params[:u]

    #the search_url is our pages that lists their legislators
    #what happens if cookies aren't enabled? My guess is we don't have to worry about this?
    @search_url = "http://tellmypolitician.com/" + cookies["zip"]

    #the target_url is the legislators contact form.
    #this will most likely be passed by a query string from the previous page.
    @target_url= params[:target_url]

    #here we need to go ahead and write out the link_destination.

  end
end
