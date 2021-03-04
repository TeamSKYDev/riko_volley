module Data
  10.times do |i|
    title = "#{(i+1).to_s}月の練習日程について（予定）"
    body = "#{(i+1).to_s}月の練習日程についてお知らせします。現状の予定なのでこれから中止になる可能性あります。"

    Post.create(
      user_id: 1,
      title: title,
      body: body
    )
  end
end