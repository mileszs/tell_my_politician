class LegislatorsController < ApplicationController
  layout :choose_layout

  def search
    setup_search(legislators_url(:u => params[:u]))
  end

  def bm_search
    setup_search(bm_legislators_url(:u => params[:u]))
  end

  def index
    setup_index
  end

  def bm_index
    setup_index
  end

  private

  def setup_search(redirect_url)
    @link = Link.find_or_create_by_url(params[:u], :title => params[:title])
    if !cookies["zip"].to_s.blank?
      redirect_to redirect_url
    end
  end

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

  def choose_layout
    ['bm_search', 'bm_index'].include?(action_name) ? 'bookmarklet' : 'application'
  end
end
