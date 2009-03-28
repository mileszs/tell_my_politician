class LegislatorsController < ApplicationController

  def search
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
