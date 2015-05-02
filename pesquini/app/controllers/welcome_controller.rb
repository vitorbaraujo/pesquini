class WelcomeController < ApplicationController
    def index
        @search = Enterprise.search(params[:q])
        @enterprises = @search.result
    end
 end
