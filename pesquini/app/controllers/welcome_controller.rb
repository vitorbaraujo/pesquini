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
    @enterprises = nil
    @search = nil
    parameters_to_search = []

    params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]

    parameters_to_search = params[:q]
    parameters_to_search.try(:merge, m: 'or')

    @search = Enterprise.search(parameters_to_search)

    if !@search.nil?
      assert(@search.kind_of?(Ransack::Search))
    end

    @enterprises = @search.result

    assert(@enterprises.kind_of?(Enterprise::ActiveRecord_Relation))

    @enterprises.each do |enterprise|
      assert(enterprise.kind_of?(Enterprise))
    end

    return @enterprises
  end

end
