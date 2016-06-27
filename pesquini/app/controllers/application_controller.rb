#  File: application
#  Purpose: File that renders javascript in show view
#  License : LGPL. No copyright.
# This controller contains the logic involving generate mensag the erro correspondent view of a single user.

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found

# name: raise_not_found
# explanation: this method set default error message for routing errors in controllers.
# parameters:
# - non
# return: none

  def raise_not_found!
      raise ActionController::RoutingError.new("No route matches \
      #{params[:unmatched_route]}")
  end

# name: render_not_found
# explanation: this method set default error message that was called when an error
# parameters:
# - non
# return: none

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
