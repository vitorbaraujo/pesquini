class GraphicsController < ApplicationController
  @@states_list = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR", 
                   "PB", "RN", "CE", "AL", "RR", "SE", "RO", "Não Informado", "AC", 
                   "TO", "GO", "PE", "AP", "MS", "MT", "MA", "PI"]

  def index
    @data = total_by_state
    puts "a"*80, @data 
  end

  def total_by_state
    @results = []
    @@states_list.each do |s|
      state = State.find_by_abbreviation("#{s}")
      #puts state.inspect, "a"*80 ,state[:id]
      sanctions = Sanction.where(state_id: state[:id])
      @results << sanctions.count
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
