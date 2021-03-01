class Exercise < ApplicationRecord

  def self.search_for(schedule)
    if schedule.include?("今日")
      exercises = Exercise.where(started_at: Date.today.all_day)
      schedule_text = "今日"
    elsif schedule.include?("明日")
      exercises = Exercise.where(started_at: Date.tomorrow.all_week)
      schedule_text = "明日"
    elsif schedule.include?("今週")
      exercises = Exercise.where(started_at: Date.today.all_week)
      schedule_text = "今週"
    elsif schedule.include?("来週")
      exercises = Exercise.where(started_at: Date.today.next_week.all_week)
      schedule_text = "来週"
    elsif schedule.include?("今月")
      exercises = Exercise.where(started_at: Date.today.all_month)
      schedule_text = "今月"
    elsif schedule.include?("来月")
      exercises = Exercise.where(started_at: Date.today.next_month.all_month)
      schedule_text = "来月"
    end

    return exercises, schedule_text
  end

  def set_response(schedule)
    response = schedule + "の予定は　\n"
    self.each do |exercise|
      response = response + exercise.started_at.strftime("%m/%d-%H:%M") + "~ @" + exercise.place.name + "\n"
    end

    response = response + "です！"
    return response
  end
end
