ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port    => 465,
    :domain  => "tellmypolitician.com",
    :authentication=> :login,
    :user =>"requests@tellmypolitician.com",
    :password=>"notifyus"
}

