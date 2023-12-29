class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # 로그인 성공
      session[:user_id] = user.id
      redirect_to user_path(user), notice: 'ログインしました。'
    else
      # 로그인 실패
      flash.now[:alert] = '無効なメール/パスワードの組み合わせです。'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'ログアウトしました。'
  end
end
