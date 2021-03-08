require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RikoVolley
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # libファイルを読み込めるようにする
    config.paths.add 'lib', eager_load: true

    # タイムゾーン設定
    config.time_zone = 'Tokyo'

    # 日本語化
    config.i18n.default_locale = :ja

    # deviseレイアウト崩れ防止
    config.action_view.field_error_proc = Proc.new do |html_tag, instance| 
      html_tag
    end
  end
end
