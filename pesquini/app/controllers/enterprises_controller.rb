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
    @enterprise = Enterprise.find(params[:id])
    @collection = Sanction.where(enterprise_id: @enterprise.id)
    @payments = Payment.where(enterprise_id: @enterprise.id).paginate(:page => params[:page], :per_page => @per_page )
    @sanctions = @collection.paginate(:page => params[:page], :per_page => @per_page)
    @payment_position = enterprise_payment_position(@enterprise)
    @position = Enterprise.enterprise_position(@enterprise)
  end

  # name: enterprise_payment_position
  # explanation: Finds a enterprise in the ranking for payments
  # parameters:
  #- enterprise: A object of Enterprise class
  # return: Position in ranking
  def enterprise_payment_position(enterprise)
    p = Enterprise.featured_payments
    p.each_with_index do |a, index|
      if a.payments_sum == enterprise.payments_sum
        return index + 1
      else
        # Nothing to do
      end
    end
  end
end
