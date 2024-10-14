class TopController < ApplicationController
  def main
    if session[:login_uid].nil?
      render 'login'
    else
      @user = User.find_by(uid: session[:login_uid])
      @hashed_pass = @user.pass if @user  # ハッシュ値を取得
      render 'main'
    end
  end

  # ログイン処理
  def login
    # ユーザーをUIDで検索
    user = User.find_by(uid: params[:uid])

    # ユーザーが存在し、入力されたパスワードとユーザーのパスワードが一致するかを確認
    if user && BCrypt::Password.new(user.pass) == params[:pass]
      # ログイン成功時、セッションにユーザーIDを保存
      session[:login_uid] = user.uid
      redirect_to action: :main
    else
      # ログイン失敗時、エラーメッセージを表示
      flash.now[:alert] = 'IDまたはパスワードが間違っています。'
      render 'login'  
    end
  end

  # ログアウト処理
  def logout
    # セッションからユーザーIDを削除
    session.delete(:login_uid)
    redirect_to action: :main
  end
  
  # ユーザー新規登録画面を表示
  def new
    @user = User.new  # ユーザー登録の新しいインスタンスを作成
    render 'new_user' # 修正: 'new_user'に変更
  end
  
  # 新規ユーザーを作成
  def create_user
    uid = params[:user][:uid]
    pass = params[:user][:pass]

    # パスワードを暗号化して保存
    encrypted_pass = BCrypt::Password.create(pass)
    @user = User.new(uid: uid, pass: encrypted_pass)

    if @user.save
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      render 'new_user', status: :unprocessable_entity
    end
  end
end
