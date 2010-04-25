# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

require_dependency 'application_controller'

require File.join(File.dirname(__FILE__), 'vendor/octopi/lib/octopi')

class IssueTrackerExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/issue_tracker"

  define_routes do |map|
    map.connect 'admin/issues/new', :controller => 'admin/issues', :action => 'new', :methods => ['get', 'post']
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :issues
    end
  end
  
  def activate
    # admin.tabs.add "Issue Tracker", "/admin/issue_tracker", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Issue Tracker"
  end
  
end
