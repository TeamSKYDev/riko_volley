class Post < ApplicationRecord
  has_many :exercises, dependent: :destroy
  accepts_nested_attributes_for :exercises

  belongs_to :user

  validates :title, presence: true

  def create_message
    message = self.title
    message = message + "\n" + self.body
    if self.exercises.present?
      message = message + "\n〇練習日程"
      self.exercises.each do |exercise|
        message = message +"\n" + exercise.started_at.strftime("%m/%d %H:%M") + "~ @" + exercise.place_name
      end
    end
    return message
  end
end
