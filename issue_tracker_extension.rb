# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class IssueTrackerExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/issue_tracker"
  
  # define_routes do |map|
  #   map.namespace :admin, :member => { :remove => :get } do |admin|
  #     admin.resources :issue_tracker
  #   end
  # end
  
  def activate
    # admin.tabs.add "Issue Tracker", "/admin/issue_tracker", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Issue Tracker"
  end
  
end
