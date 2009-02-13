class LegislatorsController < ApplicationController

  def search
    @link = Link.create(params[:link])
    @user = UserLink.create({ :ip => request.remote_ip, :link_id => @link.id })
  end

  def index
    @results = Legislator.all_for(:address => params[:address])
    respond_to do |format|
      format.html
      #format.js { }
    end
  end
end