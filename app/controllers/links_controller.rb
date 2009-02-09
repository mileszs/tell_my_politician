class LinksController < ApplicationController
  def add
    @link = Link.create(params[:link])
    @user = UserLink.create({ :ip => request.remote_ip, :link_id => @link.id })
  end
end
