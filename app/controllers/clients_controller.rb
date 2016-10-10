class ClientsController < ApplicationController
  respond_to :html

  def index
    respond_with @clients = Client.all
  end

  def import
    Client.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end

end