class Admin::IssuesController < ApplicationController

  def initialize
    super
    @github_username = @config['issue_tracker.github.username']
    @github_token = @config['issue_tracker.github.token']
    @github_repository = @config['issue_tracker.github.repository']
  end

  def index
    github do |repo|
      @issues = repo.issues.reverse
    end
  end

  def new
    @issue = Octopi::Issue.new
  end

  def create
    if params[:issue][:title].empty? or params[:issue][:body].empty?
      flash[:error] = "Validation errors occurred while processing this form. Please take a moment to review the form and correct any input errors before continuing."
    end

    number = 0
    github do |repo|
      body = params[:issue][:body] + "\n[submitted by #{current_user.name} (#{current_user.email})]"
      issue = Octopi::Issue.open(:user => @github_username, :repo => repo, :params => { :title => params[:issue][:title], :body => body })
      issue.add_label(params[:label])
      number = issue.number
    end
    flash[:notice] = "Thank you for your request!"
    redirect_to admin_issue_url(number)
  end

  def show
    github do |repo|
      @issue = repo.issue(params[:id])
    end
  end

  class OctopiWrapper
    include Octopi
  end

  private
    def github(&block)
      o = OctopiWrapper.new
      o.authenticated_with :login => @github_username, :token => @github_token do
        yield Octopi::Repository.find(:name => @github_repository, :user => @github_username)
      end
    end


end
