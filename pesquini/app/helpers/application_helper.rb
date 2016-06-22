# File: application_helper.rb
# Purpose: Implementation of the Application Helper
# License: LGPL. No copyright.

# This helper contains auxiliar methods to be used in the whole application.

module ApplicationHelper

  # name: flash_class
  # explanation: this method returns a class for each type of flash message
  # parameters:
  # - level: symbol to inform type of flash message
  # return: string
  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
  end

end
