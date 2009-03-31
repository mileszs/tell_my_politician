module LinksHelper
require 'cgi'

	def WriteImage( bioguide_id)				
		if File.exist?("public/images/pictures/" + bioguide_id + '.jpg')
			'<img class="politician_picture" src="/images/pictures/' + bioguide_id + '.jpg"/>'
		else
			'<img class="politician_picture" src="/images/design/filler-image.jpg"/>'
		end		
        end 
        def WriteContactUrl( title, firstname, lastname, email, webform )
                '<a  onClick="javascript: pageTracker._trackPageview("/write/' + title + '/'  + firstname + '_' + lastname + '");" href="' + WriteEmailLink( email, webform ) + '" rel="nofollow">Write ' + WriteLongTitle(title) + ' ' + lastname + '</a><br/>'
        end
        def WriteWebsiteUrl( url, title,firstname, lastname)
		'<a href="' + url + '" rel="nofollow"  onClick="javascript: pageTracker._trackPageview("/website/' + title + '/' + firstname + '_' + lastname + '");">' + WriteLongTitle(title) + '&#39;s Homepage</a><br/>'		
        end
	def WriteTwitterUrl( twitter_id , title, firstname, lastname )
		if( twitter_id.length > 0)
			'<a href="http://www.twitter.com/' + twitter_id + '" rel="nofollow"  onClick="javascript: pageTracker._trackPageview("/twitter/' + title + '/' + firstname + '_' + lastname + '");">Twitter</a><br/>'
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
			'/toolbar?target_url=' + CGI.escape(webform.to_s)
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
