class ApplicationController < ActionController::Base
  # ログイン必須なページを作成
  # before_action :authenticate_user!, expect: [:index]

  # ログイン後遷移先パス指定
  # def after_sign_in_path_for(resouce)
  # end
end
