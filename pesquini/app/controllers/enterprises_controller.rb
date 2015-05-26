class EnterprisesController < ApplicationController
  def index
    if params[:q].nil?
      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
      @enterprises = Enterprise.paginate(:page => params[:page], :per_page => 10)
    else
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
      @enterprises = @search.result.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    @enterprise = Enterprise.find(params[:id])
    @collection = Sanction.where(enterprise_id: @enterprise.id)
    @sanctions = @collection.paginate(:page => params[:page], :per_page => 10)
  end
 end
