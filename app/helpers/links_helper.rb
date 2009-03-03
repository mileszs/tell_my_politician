module LinksHelper
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
			'Represenitive'
		when 'Sen'
			'Senator'
		end 
	end 
	def WriteEmailLink( email, webform )
		if webform.length > 0
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
end
