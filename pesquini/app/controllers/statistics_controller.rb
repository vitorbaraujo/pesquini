class StatisticsController < ApplicationController
@@states_list = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR", 
                   "PB", "RN", "CE", "AL", "RR", "SE", "RO","PI" , "AC", 
                   "TO", "GO", "PE", "AP", "MS", "MT", "MA","Não Informado"]

  def  index
#    @enterprises = Enterprise.featured
  end

  def most_sanctioned_ranking
    @enterprises = Enterprise.featured
  end

  def sanction_by_state_graph
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
    @results << (sanctions_by_state.count)
    end
    @results
  end



@@sanction_type_list = ["INIDONEIDADE - LEGISLAçãO ESTADUAL", "IMPEDIMENTO - LEI DO PREGãO", "PROIBIçãO - LEI ELEITORAL", "INIDONEIDADE - LEI DE LICITAçõES",
 "SUSPENSãO - LEI DE LICITAçõES", "SUSPENSãO - LEGISLAçãO ESTADUAL", "PROIBIçãO - LEI DE IMPROBIDADE", "DECISãO JUDICIAL LIMINAR/CAUTELAR QUE IMPEçA CONTR...", 
 "INIDONEIDADE - LEI DA ANTT E ANTAQ ", "INIDONEIDADE - LEI DA ANTT E ANTAQ ", 
                   "INIDONEIDADE - LEI ORGâNICA TCU"]

  def sanction_by_type_graph
    gon.sanction_types = @@sanction_type_list
    gon.dados = total_by_type
    @titulo = "Gráfico de Sanções por Tipo"
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
    f.title(:text => "Gráficos de Sanções por Tipo")
    f.xAxis(:categories => @@sanction_type_list)
    f.series(:name => "Numero de Sanções", :yAxis => 0, :data => total_by_type)
    f.yAxis [
    {:title => {:text => "Sanções", :margin => 70} },
    {:title => {:text => "Sanções"}, :opposite => true},
    ]

    f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    f.chart({:defaultSeriesType=>"column"})
  end


end