class StatisticController < ApplicationController

  def  index
#    @enterprises = Enterprise.featured
  end

  def most_sanctioned_ranking
    @enterprises = Enterprise.featured
  end

  def sanction_by_state_graph

  end


end