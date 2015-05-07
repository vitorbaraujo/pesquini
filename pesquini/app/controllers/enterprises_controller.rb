class EnterprisesController < ApplicationController
  def index
    if params[:q].nil?
      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
      @enterprises = Enterprise.all
    else
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
      @enterprises = @search.result
    end
  end

  def show
    @enterprise = Enterprise.find(params[:id])
    @sanctions = Sanction.where(enterprise_id: @enterprise.id)
  end
 end
