class UserController < ApplicationController
  def new
    @user = User.new
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
    else
      flash[:notice] = "アカウントの作成に失敗しました"
      render("user/new.html.erb")
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(
      email: params[:email],
    )
    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログインに成功しました！"
      session[:user_id] = @user.id
      redirect_to("/")
    else
      @error_message = "メールアドレス、またはパスワードが間違っています"
      flash[:notice] = "ログインに失敗しました"
      @email = params[:email]
      @password = params[:password]
      render("user/login_form.html.erb")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました！"
    redirect_to("/")
  end

  def edit
    @flag = true
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user_flag = false
    @verify_message = nil
    if params[:password] == params[:pass_verify]
      @user_flag = true
    end
    if @user.save && @user_flag
      flash[:notice] = "登録情報を変更しました"
      redirect_to("/")
    else
      if @user_flag == false
        @verify_message = "パスワードが確認用と異なっています"
      end
      render("user/edit.html.erb")
    end
  end
end
