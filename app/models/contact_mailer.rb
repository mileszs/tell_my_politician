class ContactMailer < ActionMailer::Base

	def contact(category, name, email, phone, subject, message)
		recipients send_to(category)
		from 'requests@tellmypolitician.com'
    subject 'TMP ' + category + ' request:' + subject
		sent_on Time.now
		reply_to email
		body :message => message, :phone => phone, :name => name, :email => email
	end

  private

  def send_to(category)
		case category
		when 'Press'
			'press@tellmypolitician.com'
		when 'Technical Support'
			'support@tellmypolitician.com'
		else
			'info@tellmypolitician.com'
		end
  end

end
