# File: paerser_cei_controller.rb
# Purpose: Implementation of parser controller.
# License: LGPL. No copyright.

# This class of the controller has the checks methods.

class Parser::ParserController < ApplicationController

  require 'csv'

  # Path to file for parser
  @@filename = 'parser_data/CEIS.csv'

  # Specify that the filter should be applied to the given controller actions
  before_filter :authorize, only: [:check_nil_ascii, 
                                    :check_date, 
                                    :import, 
                                    :build_state, 
                                    :build_sanction_type, 
                                    :build_enterprise, 
                                    :build_sanction, 
                                    :check_and_save]

  # name: index
  # explanation: This method calls a view and has no logic implemented.
  # parameters:
  # - none
  # return: none
  def index
  end

  # name: check_nil_ascii
  # explanation: This method checks if the field is empty.
  # parameters:
  # - text
  # return: Text in upcase or the message "Não Informado".

  def check_nil_ascii(text)
    if text.include?("\u0000")
      return "Não Informado"
    else
      return text.upcase
    end
  end

  # name: check_date
  # explanation: This method converts text in the format of date.
  # parameters:
  # - text
  # return: the date format of text.

  def check_date(text)
    begin
      return text.to_date
    rescue
      return nil
    end
  end

  # name: check_and_save
  # explanation: This method checks the data received and save it.
  # parameters:
  # - c
  # return: a C.

  def check_and_save(c)
    begin
      c.save!
      return c
    rescue ActiveRecord::RecordInvalid
      c = c.refresh!
      return c
    end
  end

end
