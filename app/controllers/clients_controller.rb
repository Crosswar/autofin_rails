class ClientsController < ApplicationController
  respond_to :html

  def index
  end

  def import
    Client.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end

end