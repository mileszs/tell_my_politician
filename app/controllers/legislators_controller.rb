class LegislatorsController < ApplicationController
  def search
    @link = Link.find_or_create_by_url(params[:u], :title => params[:title])
    if !cookies["zip"].to_s.blank?
      redirect_to legislators_url(:u => params[:u])
    end
  end

  def bm_search
    @link = Link.find_or_create_by_url(params[:u], :title => params[:title])
    if !cookies["zip"].to_s.blank?
      redirect_to bm_legislators_url(:u => params[:u])
    else
      render :layout => 'bookmarklet'
    end
  end

  def index
    setup_index
  end

  def bm_index
    setup_index
    render :layout => 'bookmarklet'
  end

  private

  def setup_index
    if params[:address]
      @address = params[:address]
      location = Geocoding::get(params[:address]).first
      cookies["zip"] = zip = location.postal_code
      cookies["lat"] = lat = location.latitude.to_s
      cookies["long"] = long = location.longitude.to_s
    elsif params[:zip]
      @address = params[:zip]
      location = Geocoding::get(params[:zip]).first
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
