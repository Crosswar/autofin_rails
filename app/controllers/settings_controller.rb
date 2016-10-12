class SettingsController < ApplicationController
  respond_to :html

  def index
  	respond_with @clients = Client.all
  end

  def new
		respond_with @settings = Settings.new
  end

  def create
    @clients = Client.import(params[:file])
    redirect_to root_url
  end

end