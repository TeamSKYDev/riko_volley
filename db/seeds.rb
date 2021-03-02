# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  email: "a@a",
  password: "aaaaaa"
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

Notification.create(
  id: 1,
  status: true,
  days_before: 1
)