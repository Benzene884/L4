require 'bcrypt'
#ユーザ登録のアクション
signup_password = BCrypt::Password.create("my password")
puts signup_password

#ログインのアクション
login_password = BCrypt::Password.new(signup_password)
if login_password == "my password"  # 半角のダブルクォーテーションを使用
    p "ログイン成功"
end