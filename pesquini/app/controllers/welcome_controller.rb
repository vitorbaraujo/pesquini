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
    params[:q][:cnpj_eq] = params[:q][:corporate_name_cont] unless params[:q].nil?
    @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
    @enterprises = @search.result
  end

end
