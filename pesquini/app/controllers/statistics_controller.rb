class StatisticsController < ApplicationController


######################################################
# Declarações de variáveis Globais

@@states_list = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR",
                   "PB", "RN", "CE", "AL", "RR", "SE", "RO","PI" , "AC",
                   "TO", "GO", "PE", "AP", "MS", "MT", "MA","Não Informado"]

@@sanjana = ["Todos",1988, 1991, 1992, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
             2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013,
             2014, 2015]

@@sanction_type_list = [
 [ "INIDONEIDADE - LEGISLAçãO ESTADUAL", "Inidoneidade - Legislação Estadual"],
 [ "IMPEDIMENTO - LEI DO PREGãO", "Impedimento - Lei do Pregão"],
 [ "PROIBIçãO - LEI ELEITORAL", "Proibição - Lei Eleitoral"],
 [ "INIDONEIDADE - LEI DE LICITAçõES","Inidoneidade - Lei de Licitações"],
 [ "SUSPENSãO - LEI DE LICITAçõES","Suspensão - Lei de Impedimento Licitações"],
 [ "SUSPENSãO - LEGISLAçãO ESTADUAL", "Suspensão - Legislação estadual"],
 [ "PROIBIçãO - LEI DE IMPROBIDADE", "Proibição - Lei de improbidade"],
 [ "DECISãO JUDICIAL LIMINAR/CAUTELAR QUE IMPEçA CONTRATAçãO","Decisão Judicial liminar"] ,
 [ "INIDONEIDADE - LEI DA ANTT E ANTAQ ","Inidoneidade - Lei da ANTT e ANTAQ"] ,
 [ "INIDONEIDADE - LEI ORGâNICA TCU", "Inidoneidade - Lei Orgânica TCU"],
 [ "IMPEDIMENTO - LEGISLAçãO ESTADUAL", "Impedimento - Legislação Estadual"],
 [ "SUSPENSãO E IMPEDIMENTO - LEI DE ACESSO à INFORMAçãO","Suspensão e Impedimento - Lei de Acesso à Informação"],
 [ "PROIBIçãO - LEI ANTITRUSTE", "Proibição - Lei Antitruste"],
 [ "IMPEDIMENTO - LEI DO RDC", "Impedimento - Lei do RDC"],
 [ "PROIBIçãO - LEI AMBIENTAL", "Proibição - Lei Ambiental" ],
 ]


######################################################
# Métodos da controller

  def  index
  end

  def most_sanctioned_ranking
    @enterprise_group = []
    @enterprise_group_count = []
    a = Enterprise.all.sort_by{|x| x.sanctions_count}
    b = a.uniq.group_by(&:sanctions_count).to_a.reverse

    b.each do |k|
      @enterprise_group << k[0]
      @enterprise_group_count << k[1].count
    end
  end

  def enterprise_group_ranking
    @quantidade = params[:sanctions_count]
    @enterprises = Enterprise.where(sanctions_count: @quantidade).paginate(:page => params[:page], :per_page => 10)
  end

  def sanction_by_state_graph
    gon.states = @@states_list
    gon.dados = total_by_state
    titulo = "Gráfico de Sanções por Estado"
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => titulo)
      if(params[:year_].to_i != 0)
         f.title(:text => params[:year_].to_i )
       end
      f.xAxis(:categories => @@states_list)
      f.series(:name => "Número de Sanções", :yAxis => 0, :data => total_by_state)
      f.yAxis [
      {:title => {:text => "Sanções", :margin => 30} },
      ]
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end
  end


 def sanction_by_type_graph
    titulo = "Gráfico Sanções por Tipo"
    @chart = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({:defaultSeriesType=>"pie" ,:margin=> [50, 10, 10, 10]} )
        f.series({
                 :type=> 'pie',
                 :name=> 'Sanções Encontradas',
                 :data => total_by_type
        })
        f.options[:title][:text] = titulo
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

    if (!@states)
      @states = @@states_list.clone
      @states.unshift("Todos")
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end

  end


######################################################
# Métoodos auxiliares

  def percentual_sanction(value)
      total = Sanction.all.count
      value * 100 / total
  end



  def total_by_state()
    results = []
    @years = @@sanjana
    @@states_list.each do |s|
      state = State.find_by_abbreviation("#{s}")
      sanctions_by_state = Sanction.where(state_id: state[:id])
      selected_year = []
      if(params[:year_].to_i != 0)
        sanctions_by_state.each do |s|
          if(s.initial_date.year ==  params[:year_].to_i)
            selected_year << s
          end
      end
        results << (selected_year.count)
      else
        results << (sanctions_by_state.count)
      end
    end
    results
  end


  def total_by_type()
    results = []
    results2 = []
    cont = 0

    state = State.find_by_abbreviation(params[:state_])

    @@sanction_type_list.each do |s|
      sanction = SanctionType.find_by_description(s[0])
      sanctions_by_type = Sanction.where(sanction_type:  sanction)
      if (params[:state_] && params[:state_] != "Todos")
        sanctions_by_type = sanctions_by_type.where(state_id: state[:id])
      end
      cont = cont + (sanctions_by_type.count)
      results2 << s[1]
      results2 << (sanctions_by_type.count)
      results << results2
      results2 = []
    end
    results2 << "Não Informado"
      if (params[:state_] && params[:state_] != "Todos")
        total =Sanction.where(state_id: state[:id] ).count
      else
        total = Sanction.count
      end
    results2 << (total - cont)
    results << results2
    results = results.sort_by { |i| i[0] }
    results
  end


end