class LegislatorsController < ApplicationController
  layout :choose_layout

  def search
    setup_search(legislators_url(:u => params[:u]))
  end

  def bm_search
    setup_search(bm_legislators_url(:u => params[:u]))
  end

  def index
    if address = !params[:address].blank? && params[:address] || !params[:zip].blank? && params[:zip]
      location = Geocoding::get(address).first
      cookies['zip'], cookies['lat'], cookies['long'] = location.postal_code.to_s, location.latitude.to_s, location.longitude.to_s
    end
    lat, long = cookies["lat"], cookies["long"]

    @link = Link.find_or_create_by_url(params[:u], :title => params[:title])
    @user = UserLink.create({
      :ip         => request.remote_ip,
      :link_id    => @link.id,
      :client_id  => params[:client],
      :lat        => lat,
      :long       => long
    })
    @results = Legislator.all_for(:latitude => lat, :longitude => long)

    if @results.nil? 
      flash[:notice] = "We did not find your legislators please try again. Include your full address with zip code for best results"
      redirect_to search_url
    end

  end

  alias_method :bm_index, :index

  private

  def setup_search(redirect_url)
    @link = Link.find_or_create_by_url(params[:u], :title => params[:title])
    if !cookies["zip"].to_s.blank?
      redirect_to redirect_url
    end
  end

  def choose_layout
    ['bm_search', 'bm_index'].include?(action_name) ? 'bookmarklet' : 'application'
  end
end
