class TopController < ApplicationController
  def main
    if session[:login_uid] # sessionのスペル修正
      render "main"
    else
      render "login"
    end
  end # end を追加して def ブロックを閉じる

#  def login
#    uid = params[:uid]
#    pass = params[:pass]
#    
#    # Userモデルのauthenticateメソッドを呼び出し
#    user = User.authenticate(uid, pass)

#    if user
#      session[:login_uid] = user.uid
#      redirect_to top_main_path
#    else
#      render "error", status: 422
#    end
#  end
    
    
#  def logout
#    session.delete(:login_uid)
#    redirect_to root_path
#  end
#end



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
      # ログイン失敗時、エラーページを表示
      render "error", status: 422
    end
  end
  # ログアウト処理
  def logout
    # セッションからユーザーIDを削除
    session.delete(:login_uid)
    redirect_to action: :main
  end
end