# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  [
    {
      email: "a@a",
      password: "aaaaaa"
    },
    {
      email: "b@b",
      password: "bbbbbb",
      is_admin: true
    }
  ]
)

Omake.create(
  [
    {
      key_word: "creators作成者",
      response: "Koki & Shuya"
    },

    {
      key_word: "天才",
      response: "Shuya"
    },

    {
      key_word: "ありがとうサンクスさんきゅあざす",
      response: "どういたしまして！使ってくれてありがとう！"
    },

    {
      key_word: "もんだ",
      response: "かどたろう"
    },

  ]

)
Post.create( 
  user_id: 1,
  title: '8月の練習日程について（予定）',
  body: '８月の練習日程についてお知らせします。現状の予定なのでこれから中止になる可能性あります。'
)

Notification.create(
  id: 1,
  status: true,
  days_before: 1
)

Place.create(
  [
    {
      name: "大久保小",
      position: 2
    },
    {
      name: "戸塚第3小",
      position: 3
    },
    {
      name: "西戸山小",
      position: 4
    }
  ]
)