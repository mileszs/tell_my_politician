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
    # 1 = bookmarklet
    # 2 = wordpress plugin
    # 3 = javascript button


    #url and title will be urlencoded how do we undo this in rails?
    @link = Link.find_or_create_by_url(params[:u], :title => params[:title])
    if !cookies["zip"].to_s.blank?
      redirect_to legislators_url(:u => params[:u])
    end
  end

  def index
    if params[:address]
      @address = params[:address]
      location = Geocoding::get(params[:address]).first
      cookies["zip"] = zip = location.postal_code
      cookies["lat"] = lat = location.latitude.to_s
      cookies["long"] = long = location.longitude.to_s
    else
      lat = cookies["lat"]
      long = cookies["long"]
    end
    #we should also store the lat and long for the user link.
    #just so we can see if people move? Or cheat?
    @link = Link.find_or_create_by_url(params[:u], :title => params[:title])
    @user = UserLink.create({
      :ip         => request.remote_ip,
      :link_id    => @link.id,
      :client_id  => params[:client],
      :lat        => lat,
      :long       => long
    })
    @results = Legislator.all_for( :latitude => lat , :longitude => long )
  end
end
