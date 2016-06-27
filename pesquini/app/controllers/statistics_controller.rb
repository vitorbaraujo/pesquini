# File: statistics_controller.rb
# Purpose: Implementation of Statistics Controller
# License: LGPL. No copyright.

# This controller calculates the statistics with the data application

class StatisticsController < ApplicationController

# Globals variables

#List of all states
@@states_list = State.all_states
#List of all years
@@sanjana = Sanction.all_years
#List of all types
@@sanction_type_list = SanctionType.all_sanction_types

  # name: index
  # explanation: This method calls a view and has no logic implemented.
  # parameters:
  # - none
  # return: none

  def  index
    return
  end

  # name: most_sanctioned_ranking
  # explanation: This method makes a ranking of the enterprise that 
  # was sanctioned more.
  # parameters:
  # - none
  # return: an array with the ranking.

  def most_sanctioned_ranking
    enterprise_group_array = Enterprise.most_sanctioned_ranking

    assert(enterprise_group_array.kind_of?(Enterprise))

    @enterprise_group = enterprise_group_array[0]
    @enterprise_group_count = enterprise_group_array[1]

    return enterprise_group_array
  end

  # name: most_paymented_ranking
  # explanation: This method makes a ranking of the enterprise that 
  # was paymented more.
  # parameters:
  # - none
  # return: an array with the ranking and paginate ranking.

  def most_paymented_ranking
    @all = false
    if params[:sanjana]
      @all = true
      @enterprises = Enterprise.featured_payments.paginate(:page => params[:page], :per_page => 20)

      assert(@enterprises.kind_of?(Enterprise))
    else
      @enterprises = Enterprise.featured_payments(10)

      assert(@enterprises.kind_of?(Enterprise))
    end

    return @enterprises
  end

  # name: enterprise_group_ranking
  # explanation: This method paginates enterprises sanctions by ten per page.
  # parameters:
  # - none
  # return: the pagines.

  def enterprise_group_ranking
    @quantidade = params[:sanctions_count]

    assert(@quantidade.kind_of?(Enterprise))

    @enterprises = Enterprise.where(sanctions_count: @quantidade).paginate(:page => params[:page], :per_page => 10)

    assert(@enterprises.kind_of?(Enterprise))

    return @enterprises
  end

  # name: payment_group_ranking
  # explanation: This method paginates enterprises payments by ten per page.
  # parameters:
  # - none
  # return: the pagines.

  def payment_group_ranking
    @quantidade = params[:payments_count]

    assert(@quantidade.kind_of?(Enterprise))

    @enterprises = Enterprise.where(payments_count: @quantidade).paginate(:page => params[:page], :per_page => 10)

    assert(@enterprise.kind_of?(Enterprise))

    return @enterprises
  end

  # name: sanction_by_state_graph
  # explanation: This method makes the graph of sanctions per state.
  # parameters:
  # - none
  # return: the graph.

  def sanction_by_state_graph
    # Iniciating variables
    list_states = @@states_list
    graph_tittle = "Gráfico de Sanções por Estado"

    graphic_structure

    return @chart
  end

  # name: graprich_sanction_by_state_structure
  # explanation: This method builds the graph chart.
  # parameters:
  # - none
  # return: the chart.

  def graphic_sanction_by_state_structure
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => graph_tittle)

      if(params[:year_].to_i != 0)
        f.title(:text => params[:year_].to_i )
      else
        #nothing to do
      end

      f.xAxis(:categories => list_states)
      f.series(:name => "Número de Sanções", :yAxis => 0, :data => total_by_state)
      f.yAxis [
      {:title => {:text => "Sanções", :margin => 30} },
      ]
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end

    return @chart
  end

  # name: sanction_by_type_graph
  # explanation: This method makes the graph of sanctions per type.
  # parameters:
  # - none
  # return: the graph.

  def sanction_by_type_graph
    graprich_sanction_by_type_structure
    
    verify_state(@states)

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end

    return @chart
  end

  # name: verify_state
  # explanation: This method checks states.
  # parameters:
  # - states
  # return: States.

  def verify_state(@states)
    if (!@states)
      @states = @@states_list.clone

      assert(@states.kind_of?(Enterprise))

      @states.unshift("Todos")
    else
      #nothing to do
    end

    return @states
  end

  # name: graprich_sanction_by_type_structure
  # explanation: This method builds the graph chart.
  # parameters:
  # - none
  # return: the chart.

  def graphic_sanction_by_type_structure
    # Iniciating variables
    graph_tittle = "Gráfico Sanções por Tipo"

    @chart = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({:defaultSeriesType=>"pie" ,:margin=> [50, 10, 10, 10]} )
        f.series({
                 :type=> 'pie',
                 :name=> 'Sanções Encontradas',
                 :data => total_by_type
        })
        f.options[:title][:text] = graph_tittle
        f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto', :right=> '50px', :top=> '100px'})
        f.plot_options(:pie=>{
          :allowPointSelect=>true,
          :cursor=>"pointer" ,
          :dataLabels=>{
            :enabled=>true,
            :color=>"black",
            :style=>{
            :font=>"12px Trebuchet MS, Verdana, sans-serif"
            }
          }
        })
    end
    return @chart
  end

  # name: total_by_state
  # explanation: This method count the total numner of sanctions per state.
  # parameters:
  # - none
  # return: the number of total.

  def total_by_state
    # Iniciating variables
    results = []
    @years = @@sanjana

    @@states_list.each do |s|
      state = State.find_by_abbreviation("#{s}")

      assert(state.kind_of?(State))

      sanctions_by_state = Sanction.where(state_id: state[:id])

      assert(sanctions_by_state.kind_of?(Sanction))

      selected_year = []
      if(params[:year_].to_i != 0)
        sanctions_by_state.each do |s|
          if(s.initial_date.year ==  params[:year_].to_i)
            selected_year << s
          else
            #nothing to do
          end
        end
        results << (selected_year.count)
      else
        results << (sanctions_by_state.count)
      end
    end
    return results
  end

  # name: total_by_type
  # explanation: This method count the total numner of sanctions per type.
  # parameters:
  # - none
  # return: the number of total.

  def total_by_type()
    #Iniciating variables
    results = []
    results2 = []
    cont = 0

    state = State.find_by_abbreviation(params[:state_])

    assert(state.kind_of?(State))

    count_sanction_type(sanction)

    count_sanction
  end

  # name: count_sanction_type
  # explanation: This method count the total of sanctions per tyṕe.
  # parameters:
  # - sanction
  # return: the number of sanctions per type.

  def count_sanction_type(sanction)  
    @@sanction_type_list.each do |s|
      sanction = SanctionType.find_by_description(s[0])

      assert(sanction.kind_of?(Sanction))

      sanctions_by_type = Sanction.where(sanction_type:  sanction)

      assert(sanctions_by_type.kind_of?(Sanction))

      if (params[:state_] && params[:state_] != "Todos")
        sanctions_by_type = sanctions_by_type.where(state_id: state[:id])

        assert(sanctions_by_type.kind_of?(Sanction))

      else
        #nothing to do
      end

      cont = cont + (sanctions_by_type.count)
      results2 << s[1]
      results2 << (sanctions_by_type.count)
      results << results2
      results2 = []
    end

    results2 << "Não Informado"

    return results and results2
  end

  # name: count_sanction
  # explanation: This method count the total of sanctions.
  # parameters:
  # - sanction
  # return: the number of sanctions.

  def count_sanction
    if (params[:state_] && params[:state_] != "Todos")
      total =Sanction.where(state_id: state[:id] ).count
    else
      total = Sanction.count
    end
    results2 << (total - cont)
    results << results2
    results = results.sort_by { |i| i[0] }
    
    return results and results2
  end

end