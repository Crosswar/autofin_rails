class SessionsController < ApplicationController
  respond_to :html

  def new
  	respond_with @user = UserForm.new(User.new)
  end

  def create
  end

end