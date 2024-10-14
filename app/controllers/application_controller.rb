class ApplicationController < ActionController::Base
    def L4
        session[:c] ||= 0
        session[:c] = session[:c].to_i + 1
        render plain: session[:c]
    end
    

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    #@user.pass = BCrypt::Password.create(params[:user][:pass]) # パスワードをハッシュ化
    @user.pass = BCrypt::Password.create(user_params[:pass]) # user_params[:pass]を使用

    if @user.save
      redirect_to root_path, notice: 'ユーザー登録が完了しました'
    else
      #render :new
      render :new and return
    end
  end

  private

  def user_params
    params.require(:user).permit(:uid, :pass)
  end
end
