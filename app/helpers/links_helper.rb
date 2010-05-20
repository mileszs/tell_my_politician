module LinksHelper
  require 'cgi'

  def legislator_image( bioguide_id)
    if File.exist?("public/images/pictures/" + bioguide_id + '.jpg')
      '<img class="politician_picture" src="/images/pictures/' + bioguide_id + '.jpg"/>'
    else
      '<img class="politician_picture" src="/images/design/filler-image.jpg"/>'
    end
  end

  def contact_link(title, firstname, lastname, email, webform, link_url = '')
    '<a  onClick="javascript: pageTracker._trackPageview("/write/' + title + '/'  +
      firstname + '_' + lastname + '");" href="' +
      email_link(email, webform, link_url) +
      '" rel="nofollow">Write ' + full_title(title) + ' ' + lastname + '</a><br/>'
  end

  def website_link(url, title, firstname, lastname)
    '<a href="' + topify(url) + '" rel="nofollow"  onClick="javascript: pageTracker._trackPageview("/website/' + title + '/' + firstname + '_' + lastname + '");">' + full_title(title) + '&#39;s Homepage</a><br/>'
  end

  def twitter_link(twitter_id, title, firstname, lastname)
    unless twitter_id.blank?
      url = "http://www.twitter.com/" + twitter_id
      '<a href="'+ topify(url)  + '" rel="nofollow"  onClick="javascript: pageTracker._trackPageview("/twitter/' + title + '/' + firstname + '_' + lastname + '");">Twitter</a><br/>'
    end
  end

  def full_party_name(party)
    case party
    when 'D'
      'Democrat'
    when 'R'
      'Republican'
    when 'I'
      'Independent'
    end
  end

  def full_title(title)
    case title
    when 'Rep'
      'Representative'
    when 'Sen'
      'Senator'
    end
  end

  def email_link(email, webform, link_url = '')
    email.present? ? 'mailto:' + email.to_s : webform
  end

  def district_or_seniority(str)
    return "District #{str}" if str =~ /^\d$/
    str
  end

  def topify(url)
    'javascript:window.top.location=\'' + url + '\''
  end

  def results_title(district, state)
    title("#{state} District #{district}") if district =~ /^\d$/
  end

  def full_address( address )
    unless address.blank?
      zip = '20510'
      if( address.upcase.include?( 'CANNON' ) || address.upcase.include?( 'LONGWORTH' ) || address.upcase.include?( 'RAYBURN' ))
        zip = '20515'
      end
      address = '<address>' + address;
      address += '<br/> Washington D.C., ' + zip
      address += "</address>"
    end
  end

end
