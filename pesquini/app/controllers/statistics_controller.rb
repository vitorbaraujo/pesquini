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


@@sanction_type_list = Hash.new

#@@sanction_type_list = ["INIDONEIDADE - LEGISLAçãO ESTADUAL", "IMPEDIMENTO - LEI DO PREGãO", "PROIBIçãO - LEI ELEITORAL", "INIDONEIDADE - LEI DE LICITAçõES",
 #{}"SUSPENSãO - LEI DE LICITAçõES", "SUSPENSãO - LEGISLAçãO ESTADUAL", "PROIBIçãO - LEI DE IMPROBIDADE", "DECISãO JUDICIAL LIMINAR/CAUTELAR QUE IMPEçA CONTRATAçãO", 
 #{}"INIDONEIDADE - LEI DA ANTT E ANTAQ ",  "INIDONEIDADE - LEI ORGâNICA TCU", "IMPEDIMENTO - LEGISLAçãO ESTADUAL", "SUSPENSãO E IMPEDIMENTO - LEI DE ACESSO à INFORMAçãO",
 #{}"PROIBIçãO - LEI ANTITRUSTE", "IMPEDIMENTO - LEI DO RDC", "PROIBIçãO - LEI AMBIENTAL" ]

#@@sanction_type_list_2 = ["I - Legislação Estadual", "I - Lei do Pregão", "P - Lei Eleitoral", "I - Lei de Legistações",
 #{}"S - Lei de Licitações", "S - Legislação estadual", "P - Lei de improbidade", "Decisão Judicial liminar/ Cautela que impeça contratação", 
 #{}"I - Lei da ANTT e ANTAQ",  "I - Lei Orgânica TCU", "I - Legislação Estadual", "S e I - Lei de Acesso à Informação",
 #{}"P - Lei Antitruste", "I - Lei do RDC", "P - Lei Ambiental" ]


@@sanction_type_list = [
 [ "SUSPENSãO E IMPEDIMENTO - LEI DE ACESSO à INFORMAçãO","S e I - Lei de Acesso à Informação"],
 [ "PROIBIçãO - LEI AMBIENTAL", "P - Lei Ambiental" ],
 [ "PROIBIçãO - LEI ANTITRUSTE", "P - Lei Antitruste"],
 [ "IMPEDIMENTO - LEI DO RDC", "I - Lei do RDC"],
 [ "IMPEDIMENTO - LEGISLAçãO ESTADUAL", "I - Legislação Estadual"],
 [ "DECISãO JUDICIAL LIMINAR/CAUTELAR QUE IMPEçA CONTRATAçãO","Decisão Judicial liminar "] ,
 [ "INIDONEIDADE - LEI ORGâNICA TCU", "I - Lei Orgânica TCU"],
 [ "PROIBIçãO - LEI ELEITORAL", "P - Lei Eleitoral"],
 [ "INIDONEIDADE - LEI DA ANTT E ANTAQ ","I - Lei da ANTT e ANTAQ"] ,
 [ "SUSPENSãO - LEGISLAçãO ESTADUAL", "S - Legislação estadual"],
 [ "INIDONEIDADE - LEGISLAçãO ESTADUAL", "I - Legislação Estadual"], 
 [ "INIDONEIDADE - LEI DE LICITAçõES","I - Lei de Licitações"],
 [ "PROIBIçãO - LEI DE IMPROBIDADE", "P - Lei de improbidade"],
 [ "SUSPENSãO - LEI DE LICITAçõES","S - Lei de Licitações"],
 [ "IMPEDIMENTO - LEI DO PREGãO", "I - Lei do Pregão"]
 ]



  def sanction_by_type_graph
titulo = "Gráfico Sanções por Tipo"

@chart = LazyHighCharts::HighChart.new('pie') do |f|

      f.chart({:defaultSeriesType=>"pie" , :margin=> [80, 20, 20, 20]} )
      f.series({
               :type=> 'pie',
               :name=> 'Browser share',
               :data => total_by_type
      })
      f.options[:title][:text] = titulo
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
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

end

def percentual_sanction(value)
    total = Sanction.all.count
    value * 100 / total
end

def total_by_type
    #@results = Hash.new
    #@results[:nome] = []
    #@results[:valor] = []
    @results = []
    @results2 = []
    cont = 0

    @@sanction_type_list.each do |s|
      sanction = SanctionType.find_by_description(s[0])
      sanctions_by_type = Sanction.where(sanction_type:  sanction)
      cont = cont + (sanctions_by_type.count)
    @results2 << s[1]
    @results2 << (sanctions_by_type.count)
    @results << @results2
    @results2 = []
    end
    @results2 << "Não Informado" 
    total =Sanction.all.count
    @results2 << (total - cont)
    puts 'a'*200, cont
    @results << @results2
    @results
  end

end