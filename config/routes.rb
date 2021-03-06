ActionController::Routing::Routes.draw do |map|

  map.bm_search 'bookmarklet/search', :controller => 'legislators', :action => 'bm_search'
  map.bm_legislators 'bookmarklet/legislators', :controller => 'legislators', :action => 'bm_index'
  map.resources :legislators, :only => [:index], :collection => { :search => :get }
  map.search 'search', :controller => 'legislators', :action => 'search'
  map.zip ':zip', :controller => 'legislators', :action => 'index', :zip => /\d+/

  map.root :controller => 'sites', :action => :home

  map.toolbar 'toolbar', :controller => 'toolbar'

  map.privacy 'privacy', :controller => 'sites', :action => :privacy
  map.instructions 'instructions', :controller => 'sites', :action => :bookmarklet
  map.siteinstructions 'siteinstructions', :controller=>'sites', :action=>:siteinstructions
  map.contact 'contact', :controller => 'sites', :action=> :contact
  map.sentcontact 'sentcontact', :controller => 'sites', :action => :sentcontact

  map.about 'about',:controller=>'sites',:action=>:about
  map.bookmarklet 'bookmarklet', :controller => 'sites', :action => :bookmarklet
  map.district ':slug', :controller => 'legislators', :action => 'district', :slug => /[\w+-]+\d+/ 
end
