class Batch::DailyMassage < ActionController::Base

  def client
    super
  end

  def self.send_message
    today_execises = Execise.serch_for("今日")
    if today_execises.present?
      response = today_execises.set_response("今日")

      message = {
        type: 'text',
        text: response
      }

      client.broadcast(message)
    end
  end
end