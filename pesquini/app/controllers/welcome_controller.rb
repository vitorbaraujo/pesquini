# File: welcome_controller.rb
# Purpose: Implementation of Welcome Controller
# License: LGPL. No copyright.

# This controller contains the logic involving the exhibition of a welcome page

class WelcomeController < ApplicationController

  # name: index
  # explanation: this method shows all enterprises found according to the params
  #   given
  # parameters:
  # - none
  # return: relation of objects of type Enterprise
  def index
    if !params[:q].nil?
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
    else
      # nothing to do
    end

    parameters_to_search = params[:q]
    parameters_to_search.try(:merge, m: 'or')

    @search = Enterprise.search(parameters_to_search)

    @enterprises = @search.result

    return @enterprises
  end

end
