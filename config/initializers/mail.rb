ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "tellmypolitician.com",
  :authentication       => :plain,
  :user_name            => "requests@tellmypolitician.com",
  :password             => "notifyus"
}
