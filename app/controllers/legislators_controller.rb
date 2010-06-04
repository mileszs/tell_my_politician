class LegislatorsController < ApplicationController
  layout :choose_layout

  def search
    setup_search(legislators_url(:u => params[:u]))
  end

  def bm_search
    setup_search(bm_legislators_url(:u => params[:u]))
  end

  def index
    if address = (params[:address].present? && params[:address]) || (params[:zip].present? && params[:zip])
      @location = Geocoding::get(address).first
      session[:address] = address
      cookies['zip'], cookies['lat'], cookies['long'] = @location.postal_code.to_s, @location.latitude.to_s, @location.longitude.to_s
      save_meta_data(@location.latitude, @location.longitude)
    end

    if @district = Sunlight::District.get(:latitude => @location.latitude, :longitude => @location.longitude)
      redirect_to district_url(:slug => US_STATES[@district.state].downcase.gsub(' ', '-') + '-' + @district.number)
    else
      flash[:notice] = "We were unable to find any legislators. Please be sure to include your full address, with ZIP, and try again."
      redirect_to search_url
    end

  # Be sure to comment this section out when debugging. It swallows a lot of errors.
  rescue NoMethodError => e
    flash.now[:notice] = 'There seems to be an issue with your address.  Please double-check it, and try again.'
    render :action => :search
  end

  def district
    state, number = parse_district_slug
    state_abbrev = US_STATES.invert[state]
    if state_abbrev.nil?
      logger.info("US state '#{state}' does not exist.")
      render_404
    end
    @results = Sunlight::Legislator.all_in_district(Sunlight::District.new(US_STATES.invert[state.titleize], number))
    if @results[:representative].blank?
      logger.info("The district #{state.titleize} #{number} does not exist.")
      render_404
    end
  end

  alias_method :bm_index, :index

  private

  def choose_layout
    ['bm_search', 'bm_index'].include?(action_name) ? 'bookmarklet' : 'application'
  end

  def setup_search(redirect_url)
    @link = Link.find_or_create_by_url(params[:u], :title => params[:title]) unless params[:u].nil?
    if cookies["zip"].to_s.present?
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

  def parse_district_slug
    parts = params[:slug].split('-')
    number = parts.last
    state = parts[0..parts.size-2].join(" ").titleize
    [state, number]
  end
end
