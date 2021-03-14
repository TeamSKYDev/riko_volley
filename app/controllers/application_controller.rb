class ApplicationController < ActionController::Base

  # ログイン後遷移先パス指定
  def after_sign_in_path_for(resouce)
    posts_path
  end
  # ログアウト後遷移先パス指定
  def after_sign_out_path_for(resouce)
    posts_path
  end

  def check_sign_in
    if !user_signed_in?
      redirect_to posts_path
    end
  end

  private
  # botアカウント(クライアント)設定
  def client
    case Rails.env
    when "production"
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    when "test", "development"
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["DEV_LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["DEV_LINE_CHANNEL_TOKEN"]
      }
    end
  end

end
