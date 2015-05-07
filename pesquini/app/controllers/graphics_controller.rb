class GraphicsController < ApplicationController
  @@states_list = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR", 
                   "PB", "RN", "CE", "AL", "RR", "SE", "RO", "Não Informado", "AC", 
                   "TO", "GO", "PE", "AP", "MS", "MT", "MA", "PI"]

  def index
    @data = total_by_state
    @states = @@states_list
      gon.xd = @@states_list[0]
  end

  def percentual_sanction(value)
      total = Sanction.all.count
      value * 100 / total
  end

  def total_by_state
    @results = []
    @@states_list.each do |s|
      state = State.find_by_abbreviation("#{s}")
      sanctions_by_state = Sanction.where(state_id: state[:id])
    @results << percentual_sanction(sanctions_by_state.count)
    end
    @results
  end

  def pie_graphics 
    data = Hash.new
    total = total_by_state
    @@states_list.each.with_index do |s,index|
      data[:s] = total[index]
    end
    data 
  end
end
