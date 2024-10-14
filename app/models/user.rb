class User < ApplicationRecord
  # ユーザーログイン時にパスワードを暗号化して比較する
  def self.authenticate(uid, pass)
    user = find_by(uid: uid)
    return nil unless user

    # BCryptを使用してパスワードを比較
    return user if BCrypt::Password.new(user.pass) == pass

    nil
  end
end
