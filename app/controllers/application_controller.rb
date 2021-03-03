class ApplicationController < ActionController::Base
  # ログイン必須なページを作成
  # before_action :authenticate_user!, expect: [:index]

  # ログイン後遷移先パス指定
  def after_sign_in_path_for(resouce)
    posts_path
  end
  # ログアウト後遷移先パス指定
  def after_sign_out_path_for(resouce)
    posts_path
  end

  private
  # botアカウント(クライアント)設定
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

end
