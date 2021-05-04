class Users::SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(user_params)
    if user = User.authenticate_with_credentials(user_params[:email], user_params[:password])
      @session.save
      redirect_to [:root]
    else
      render :template  => "users/sessions/new"
    end
  end

  def destroy
    @session = Session.find params[:id]
    @session.destroy
    redirect_to [:new, :users, :session]
  end

  private

  def user_params
    params.require(:session).permit(
      :email,
      :password,
      )
  end
end
