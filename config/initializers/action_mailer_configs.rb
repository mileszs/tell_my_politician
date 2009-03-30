#ActionMailer::Base.smtp_settings = {
#    :address => "smtp.gmail.com",
#    :port    => 465,
#    :domain  => "tellmypolitician.com",
#    :authentication=> :login,
#    :user =>"requests@tellmypolitician.com",
#    :password=>"notifyus"
#}
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
#:tls => true,
:address => "smtp.gmail.com",
:port => 587,
#:domain => "tellmypolitician.com",
:authentication => :plain,
:user_name => "requests@tellmypolitician.com",
:password => "notifyus"
}

