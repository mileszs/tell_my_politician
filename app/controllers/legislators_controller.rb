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
      @location = Geocoding::get(address).first
      cookies['zip'], cookies['lat'], cookies['long'] = @location.postal_code.to_s, @location.latitude.to_s, @location.longitude.to_s
    end
    save_meta_data(@location.latitude, @location.longitude)
    @results = Legislator.all_for(:latitude => @location.latitude, :longitude => @location.longitude)
  rescue NoMethodError => e
    flash.now[:notice] = 'There seems to be an issue with your address.  Please double-check it, and try again.'
    logger.warn "------------------------------------------------------\n"
    logger.warn "- There's probably an issue with the entered address -\n"
    logger.warn "------------------------------------------------------\n"
    logger.warn e.inspect
    render :action => :search
  end

  alias_method :bm_index, :index

  private

  def choose_layout
    ['bm_search', 'bm_index'].include?(action_name) ? 'bookmarklet' : 'application'
  end

  def setup_search(redirect_url)
    @link = Link.find_or_create_by_url(params[:u], :title => params[:title])
    if !cookies["zip"].to_s.blank?
      redirect_to redirect_url
    end
  end

  def save_meta_data(lat, long)
    @link = Link.find_or_create_by_url(params[:u], :title => params[:title])
    @user = UserLink.create({
      :ip         => request.remote_ip,
      :link_id    => @link.id,
      :client_id  => params[:client],
      :lat        => lat,
      :long       => long
    })
  end
end
