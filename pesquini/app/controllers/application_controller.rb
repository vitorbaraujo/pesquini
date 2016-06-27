class ApplicationController < ActionController::Base
  include SessionsHelper
  include Assertions

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found

  def raise_not_found!
      raise ActionController::RoutingError.new("No route matches \
      #{params[:unmatched_route]}")
  end

  def render_not_found
      respond_to do |render_not_found|
      render_not_found.html{ render :template => "errors/404", :status => 404 }
      assert__render_not_found (render)
    end
  end

  def assert(condition)
   if(condition)
     # nothing to do
   else
     raise_not_found!
   end
  end
end
