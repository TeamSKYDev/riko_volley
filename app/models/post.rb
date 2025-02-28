class Post < ApplicationRecord
  has_many :exercises, ->{order('started_at')}, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :exercises

  belongs_to :user

  validates :title, presence: true

  def create_message
    message = self.title
    message = message + "\n" + self.body
    if self.exercises.present?
      message = message + "\n〇練習日程"
      self.exercises.each do |exercise|
        message = message +"\n" + exercise.started_at.strftime("%m/%d(#{I18n.t('date.abbr_day_names')[exercise.started_at.wday]}) %H:%M") + "~ @" + exercise.place_name
      end
    end
    return message
  end

  def edit_message(past_title)
    if self.title == past_title
      message = "「" + self.title + "」に変更がありました！\nURLから確認してください！"
    else
      message = "「" + past_title + "」に変更がありました！\nタイトルが「" + self.title + "」に変わっています。\nURLから確認してください！"
    end
    return message
  end
end
