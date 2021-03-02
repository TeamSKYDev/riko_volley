namespace :heroku_scheduler do
  desc "This task is called by the Heroku scheduler add-on"
  task :send_daily_message => :environment do
    client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }

    today_exercises, schedule = Exercise.search_for("今日")
    if today_exercises.present?
      response = today_exercises.set_response(schedule)

      message = {
        type: 'text',
        text: response
      }

      client.broadcast(message)
    end
  end
end