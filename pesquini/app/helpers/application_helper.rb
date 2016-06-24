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
    if level == :notice
      "alert alert-info"
    elsif level == :success
      "alert alert-success"
    elsif level == :error
      "alert alert-error"
    elsif level == :alert
      "alert alert-error"
    else
      # nothing to do
    end
  end

end
