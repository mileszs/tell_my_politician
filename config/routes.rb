ActionController::Routing::Routes.draw do |map|

  map.resources :legislators, :only => [:index], :collection => { :search => :get }
  map.search 'search', :controller => 'legislators', :action => 'search'

  map.root :controller => 'sites', :action => :home

  map.toolbar 'toolbar', :controller => 'toolbar'

  map.privacy 'privacy', :controller => 'sites', :action => :privacy
  map.instructions 'instructions', :controller => 'sites', :action => :bookmarklet
  map.siteinstructions 'siteinstructions', :controller=>'sites', :action=>:siteinstructions
  map.contact 'contact', :controller => 'sites', :action=> :contact

  map.about 'about',:controller=>'sites',:action=>:about
  map.bookmarklet 'bookmarklet', :controller => 'sites', :action => :bookmarklet
  # Sort of a catch all
  map.connect ':action', :controller => 'sites'

end
