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
    @per_page = 10
    @page_num = params[:page].to_i > 0 ? params[:page].to_i  - 1 : 0
    @enterprise = Enterprise.find(params[:id])
    @collection = Sanction.where(enterprise_id: @enterprise.id)
    @payments = Payment.where(enterprise_id: @enterprise.id).paginate(:page => params[:page], :per_page => @per_page )
    @sanctions = @collection.paginate(:page => params[:page], :per_page => @per_page)
    @position = enterprise_position(@enterprise)
  end

  def enterprise_position(enterprise)

      a = Enterprise.all.sort_by{|x| x.sanctions_count}
      b = a.uniq.group_by(&:sanctions_count).to_a.reverse

      b.each_with_index do |k,index|
        if k[0] == enterprise.sanctions_count
          return index + 1
        end
      end
  end
end