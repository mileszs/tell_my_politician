class LinksController < ApplicationController
  def add
    @link = Link.create(params[:link])
    @user = UserLink.create({ :ip => request.remote_ip, :link_id => @link.id })
  end

  def results
    @results = Legislator.all_for(:address => params[:address])
    respond_to do |format|
      format.html
      #format.js { }
    end
  end
end
