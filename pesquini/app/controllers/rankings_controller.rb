class RankingsController < ApplicationController

  def  index
    @enterprises = Enterprise.featured
  end

end