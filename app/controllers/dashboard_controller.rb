class DashboardController < ApplicationController
  respond_to :html

  def index
  	respond_with @clients = Client.all
  end

end