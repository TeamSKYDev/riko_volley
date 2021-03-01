class LinebotController < ApplicationController
   require 'line/bot'
   require 'json'

   # callbackアクションのCSRFトークン認証を無効
   protect_from_forgery :except => [:callback]

   # botアカウント(クライアント)設定
   def client
     @client ||= Line::Bot::Client.new { |config|
       config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
       config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
     }
   end


   def callback
     # bodyに打ち込まれた値の格納(JSON)
     body = request.body.read

     #X-Line-Signatureリクエストヘッダーに含まれる署名を検証して、リクエストがLINEプラットフォームから送信されたことを確認する必要があります.(公式)
     #アカウントによっては(課金の都合？)送信できなこともあるため、このチェックが必要
     signature = request.env['HTTP_X_LINE_SIGNATURE']
     unless client.validate_signature(body, signature)
       head :bad_request
     end

     # gem line-bot-apiのメソッド。ハッシュに変更
     events = client.parse_events_from(body)

     events.each { |event|
      if event.message['text'] != nil
        exercises, schedule = Exercise.search_for(event.message['text'])
        if exercises.present?
          response = exercises.set_response(schedule)
        else
          response = schedule + "には練習が予定されていません"
        end
      end

       case event
       when Line::Bot::Event::Message
         case event.type
         when Line::Bot::Event::MessageType::Text,Line::Bot::Event::MessageType::Location
           message = {
             type: 'text',
             text: response
           }
           client.reply_message(event['replyToken'], message)
         end
       end
     }

     head :ok
   end

end
