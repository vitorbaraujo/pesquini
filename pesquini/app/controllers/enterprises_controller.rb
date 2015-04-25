class EnterprisesController < ApplicationController
  def index
    @enterprises = Enterprise.all


  end
 end
