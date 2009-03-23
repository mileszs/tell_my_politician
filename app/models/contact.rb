class Contact < ActionMailer::Base

	def contact( category,name, email, phone, nSubject,message)

		#fiqure out who we are sending to.
		case category
		when 'Press'
			sendto = 'press@tellmypolitician.com'
		when 'Technical Support'
			sendto = 'support@tellmypolitician.com'
		else
			sendto = 'info@tellmypolitician.com'
		end

		recipients sendto
		from 'requests@tellmypolitician.com'
                subject 'TMP ' + category + ' request:' + nSubject
		sent_on Time.now
		reply_to email
		body :message=>message, :phone=>phone, :name=>name, :email=>email
	end   

end
