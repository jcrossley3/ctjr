# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Export to views
  helper_method :cluster

  # Clear the instances cache
  before_filter :clear_instance_cache

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def cluster
    @cluster ||= Cluster.new
  end

  def clear_instance_cache
    Thread.current[:instances] = nil
  end
end
