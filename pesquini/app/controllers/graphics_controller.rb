class GraphicsController < ApplicationController
  @@states_list = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR", 
                   "PB", "RN", "CE", "AL", "RR", "SE", "RO","PI" , "AC", 
                   "TO", "GO", "PE", "AP", "MS", "MT", "MA","Não Informado"]
  @initial_date

  def index
    gon.states = @@states_list
    gon.dados = total_by_state
    @titulo = "Gráfico de Sanções por Estado"
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
    f.title(:text => "Gráficos de Sanções por Estado")
    f.xAxis(:categories => @@states_list)
    f.series(:name => "Numero de Sanções", :yAxis => 0, :data => total_by_state)
    f.yAxis [
    {:title => {:text => "Sanções", :margin => 70} },
    {:title => {:text => "Sanções"}, :opposite => true},
    ]

    f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    f.chart({:defaultSeriesType=>"column"})
end
  end
  
  def total_by_state
    @results = []
    @@states_list.each do |s|
      state = State.find_by_abbreviation("#{s}")
      sanctions_by_state = Sanction.where(state_id: state[:id])
      selected_year = []
      #params[:year] = 2009
      sanctions_by_state.each do |s|
        puts params[:year_]*20
        if(s.initial_date.year ==  params[:year_].to_i)
          selected_year << s 
        end
      end
      @results << (selected_year.count)
    end
    @results
  end

  def column_graphics 
    data = Hash.new
    total = total_by_state
    @@states_list.each.with_index do |s,index|
      data[:s] = total[index]
    end
    data 
  end

  def filter_years
    respond to do |format|
      format.json{render json: @sanction.initial_date_hash}
    end
    puts @sanction.initial_date_hash
  end
end
  
