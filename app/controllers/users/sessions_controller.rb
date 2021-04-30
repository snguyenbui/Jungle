class Users::SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(user_params)
    user = User.find_by_email(user_params[:email])
    if user && user.authenticate(user_params[:password])
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
