class LegislatorsController < ApplicationController

  def search
    #incoming query string looks like
    #http://tellmypolitician.com/search?u=http%3A//www.w3schools.com/htmldom/prop_doc_title.asp&title=HTML%20DOM%20title%20Property&client=1
    #we can't rely on the referer to have the page beacuse 
    #the wordpress plugin displays the link on the 
    #list page as well as the specific blog post page.
    # u = The url the user is submitting
    # title = the title of the page the user is submiting.
    # client = the id of the client that the user is submitting.

    @link = Link.find_or_create_by_url(params[:link])
    @user = UserLink.create({ :ip => request.remote_ip, :link_id => @link.id })
    if !cookies["zip"].to_s.blank?
      redirect_to legislators_url
    end
  end

  def index
    if params[:address]
      location = Geocoding::get(params[:address]).first
      cookies["zip"] = zip = location.postal_code
      cookies["lat"] = lat = location.latitude.to_s
      cookies["long"] = long = location.longitude.to_s
    else
      lat = cookies["lat"]
      long = cookies["long"]
    end
    @results = Legislator.all_for(:latitude => lat, :longitude => long)
  end
end
