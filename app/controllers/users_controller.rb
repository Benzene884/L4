class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.pass = BCrypt::Password.create(params[:user][:pass]) # パスワードをハッシュ化して保存

    if @user.save
      session[:login_uid] = @user.uid  # ユーザーIDをセッションに保存
      redirect_to top_main_path, notice: 'ユーザー登録が完了しました。'
    else
      render :new and return  # エラーが発生した場合にだけ render を呼び出す
    end
  end

  private

  def user_params
    params.require(:user).permit(:uid, :pass)
  end
end
