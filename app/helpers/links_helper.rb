module LinksHelper
	def WriteImage( bioguide_id)				
		if File.exist?("public/images/pictures/" + bioguide_id + '.jpg')
			'<img class="politician_picture" src="./images/pictures/' + bioguide_id + '.jpg"/>'
		else
			'<img class="politician_picture" src="./images/design/filler-image.jpg"/>'
		end		
        end 
        def WriteContactUrl( title, lastname, email, webform )
                '<a  onClick="javascript: pageTracker._trackPageview("_trackEmailReferral");" href="' + WriteEmailLink( email, webform ) + '" rel="nofollow">Write ' + WriteLongTitle(title) + ' ' + lastname + '</a><br/>'
        end
        def WriteWebsiteUrl( url, title)
		'<a href="' + url + '" rel="nofollow"  onClick="javascript: pageTracker._trackPageview("_trackHomepageReferral");">' + WriteLongTitle(title) + '&#39;s Homepage</a><br/>'		
        end
	def WriteTwitterUrl( twitter_id )
		if( twitter_id.length > 0)
			'<a href="http://www.twitter.com/' + twitter_id + '" rel="nofollow"  onClick="javascript: pageTracker._trackPageview("_trackTwitterReferral");">Twitter</a><br/>'
		end
	end
	def WriteLongPartyName( party )
		case party
		when 'D'
			'Democrat'
		when 'R'
			'Republician'
		when 'I'
			'Independent'
		end
	end
	def WriteLongTitle( title )
		case title
		when 'Rep'
			'Representative'
		when 'Sen'
			'Senator'
		end
	end
	def WriteEmailLink( email, webform )
		if webform.upcase != 'NONE'
			webform.to_s
		else email.length > 0
			'mailto:' + email.to_s
		end

	end

  def district_or_seniority(str)
    if str =~ /^\d$/
      str = "District #{str}"
    else
      str
    end
  end

  def results_title(district, state)
    title("#{state} District #{district}") if district =~ /^\d$/
  end
end
