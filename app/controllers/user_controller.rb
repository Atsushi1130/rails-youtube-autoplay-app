class UserController < ApplicationController
  def new
    @user
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    if @user.save
      flash[:notice] = "登録に成功しました！"
      session[:user_id] = @user.id
      redirect_to("/")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(
      email: params[:email],
      password: params[:password]
    )
    if @user
      flash[:notice] = "ログインに成功しました！"
      session[:user_id] = @user.id
      redirect_to("/")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました！"
    redirect_to("/")
  end
end
