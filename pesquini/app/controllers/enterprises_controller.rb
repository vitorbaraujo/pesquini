class EnterprisesController < ApplicationController
  def index
    params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]

    @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
    puts params ,"asa"*20 
    @enterprises = @search.result
  end
 end
