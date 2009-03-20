class LegislatorsController < ApplicationController

  def search
    @link = Link.find_or_create_by_url(params[:link])
    @user = UserLink.create({ :ip => request.remote_ip, :link_id => @link.id })
    respond_to do |format|
      if cookies["zip"].to_s.blank?
        format.html # search.html.erb
      else
        format.html { redirect_to legislators_url }
      end
    end
  end

  def index
    if cookies["zip"].to_s.blank?
      location = Geocoding::get(params[:address]).first
      cookies["zip"] = location.postal_code
      cookies["lat"] = location.latitude.to_s
      cookies["long"] = location.longitude.to_s
      @results = Legislator.all_for(:latitude => location.latitude, :longitude => location.longitude)
    else
      @results = Legislator.all_for(:latitude => cookies[:lat], :longitude => cookies[:long])
    end
    respond_to do |format|
      format.html
    end
  end
end
