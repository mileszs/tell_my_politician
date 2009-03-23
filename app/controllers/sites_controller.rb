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

  def sentcontact
	Contact.deliver_contact( 
		params[:category],
		params[:name],
		params[:email],
		params[:phone],
		params[:subject],
		params[:message]
	)	
  end
end
