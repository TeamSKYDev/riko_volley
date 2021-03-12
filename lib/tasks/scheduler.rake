namespace :heroku_scheduler do
  desc "This task is called by the Heroku scheduler add-on"
  task :send_daily_message => :environment do
    if Notification.first.status == true
      client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }

      # n日後の予定確認
      setting_day = Notification.first.days_before
      exercises = Exercise.search_for_days_after(setting_day)

      if exercises.present?
        notification = exercises.set_notification(setting_day)

        message = {
          type: 'text',
          text: notification
        }

        client.broadcast(message)
      end
    end
  end
end