class SitesController < ApplicationController

  def home
  end

  def privacy
  end

  def contact
  end

  def instructions
  end

  def about
  end

  def bookmarklet
  end

  def siteinstructions
  end

  def sentcontact
    ContactMailer.deliver_contact(
      params[:category],
      params[:name],
      params[:email],
      params[:phone],
      params[:subject],
      params[:message]
    )
  end
end
