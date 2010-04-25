namespace :radiant do
  namespace :extensions do
    namespace :issue_tracker do
      
      desc "Runs the migration of the Issue Tracker extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          IssueTrackerExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          IssueTrackerExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Issue Tracker to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from IssueTrackerExtension"
        Dir[IssueTrackerExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(IssueTrackerExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
