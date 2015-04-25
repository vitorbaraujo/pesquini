class EnterprisesController < ApplicationController
  def index

    if params[:search]
          @enterprise = Enterprise.find_by_corporate_name(params[:search])
          @title = "Resultados para: <br/>".html_safe + "'#{params[:search]}'"
    end

    @enterprises = Enterprise.all
  end


 end
