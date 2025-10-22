class TopController < ApplicationController
  def main
    render "login_form"
  end

  def login
    # フォームが name="pass" を送っている前提。もし name="password" にするなら params[:password] に変更。
    uid = params[:uid]
    password = params[:pass]

    user = User.find_by(uid: uid)

    # authenticate は has_secure_password が有効であることが前提
    if user&.authenticate(password)
      # セッションを設定（ビューが session[:login_uid] を参照しているので合わせる）
      session[:user_id] = user.id
      session[:login_uid] = user.uid
      redirect_to tweets_path, notice: "ログインしました"
    else
      flash.now[:alert] = "ログインに失敗しました"
      # render するビューがツイート一覧を期待するなら @tweets をセットする必要あり
      # 今は login_form を再表示する想定なので login_form を描画
      render "login_form", status: :unauthorized
    end
  end

  def logout
    reset_session   # セッションをまるごとクリアするのが簡潔で安全
    redirect_to tweets_path, notice: "ログアウトしました"
  end
end
