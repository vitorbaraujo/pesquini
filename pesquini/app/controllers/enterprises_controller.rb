class EnterprisesController < ApplicationController
  def index

    if params[:q].nil?

      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))

    else
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]

      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))

      puts params ,"asa"*20 
      @enterprises = @search.result
    end


  end

  def show
    @enterprise = Enterprise.find(params[:id])
  end

 end


 #=======
 #     @search = Enterprise.search(params[:q])
 #   unless params[:q].nil?
 #     @enterprises = @search.result
 #   end
 #>>>>>>> Stashed changes