class EnterprisesController < ApplicationController
  def index

  	if params[:search]
  		@enterprise = Enterprise.search(params[:search])
    	@title = "Resultados para: <br/>".html_safe + "'#{params[:search]}'"
    end

    @enterprises = Enterprise.all
  end


 end
