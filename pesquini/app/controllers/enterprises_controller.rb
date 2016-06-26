# File: enterprises_controller.rb
# Purpose: File that implements business logic for enterprises
# License : LGPL. No copyright

class EnterprisesController < ApplicationController

  # name: index
  # explanation: page with enterprises
  # parameters:
  #- none
  # return: List of enterprises
  def index
    if params[:q].nil?
      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
      @enterprises = Enterprise.paginate(:page => params[:page], :per_page => 10)
    else
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
      @enterprises = @search.result.paginate(:page => params[:page], :per_page => 10)
    end

    return @enterprises
  end

  # name: show
  # explanation: Shows more info about a enterprise
  # parameters:
  #- none
  # return: A enterprise with it's info
  def show
    @per_page = 10
    if params[:page].to_i > 0
      @page_num = params[:page].to_i - 1
    else
      @page_num = 0
    end
    assert(params[:id].kind_of?(String))
    @enterprise = Enterprise.find(params[:id])
    assert(@enterprise.kind_of?(Enterprise))
    @collection = Sanction.where(enterprise_id: @enterprise.id)
    assert(@collection.kind_of?(Sanction::ActiveRecord_Relation))
    @payments = Payment.where(enterprise_id: @enterprise.id).paginate(:page => params[:page], :per_page => @per_page )
    assert(@payments.kind_of?(Payment::ActiveRecord_Relation))
    @sanctions = @collection.paginate(:page => params[:page], :per_page => @per_page)
    @payment_position = enterprise_payment_position(@enterprise)
    assert(@payment_position.kind_of?(Integer))
    @position = Enterprise.enterprise_position(@enterprise)

    return @position
  end

  # name: enterprise_payment_position
  # explanation: Finds a enterprise in the ranking for payments
  # parameters:
  #- enterprise: A object of Enterprise class
  # return: Position in ranking
  def enterprise_payment_position(enterprise)
    payments_featured = Enterprise.featured_payments
    assert(payments_featured.kind_of?(Enterprise::ActiveRecord_Relation))
    payments_featured.each_with_index do |another_enterprise, index|
      assert(another_enterprise.kind_of?(Enterprise))
      if another_enterprise.payments_sum == enterprise.payments_sum
        position = index + 1
        assert(position.kind_of?(Integer))
        return position
      else
        # Nothing to do
      end
    end
  end
end
