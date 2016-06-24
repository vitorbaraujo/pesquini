# File: application_helper.rb
# Purpose: Implementation of the Application Helper
# License: LGPL. No copyright.

# This helper contains auxiliar methods to be used in the whole application.

module ApplicationHelper

  # name: flash_class
  # explanation: this method returns a class for each type of flash message
  # parameters:
  # - type_of_flash_message: symbol to inform type of flash message
  # return: string
  def flash_class(type_of_flash_message)
    returned_class = ""

    if type_of_flash_message == :notice
      returned_class = "alert alert-info"
    elsif type_of_flash_message == :success
      returned_class = "alert alert-success"
    elsif type_of_flash_message == :error
      returned_class = "alert alert-error"
    elsif type_of_flash_message == :alert
      returned_class = "alert alert-error"
    else
      # nothing to do
    end

    return returned_class
  end

end
