class Exercise < ApplicationRecord

  def self.search_for(schedule)
    if schedule.include?("今週")
      execise = Execise.where(started_at: Date.today.all_week)
      schedule_text = "今週"
    elsif schedule.include?("来週")
      execise = Execise.where(started_at: Date.next_week.all_week)
      schedule_text = "来週"
    elsif schedule.include?("今月")
      execise = Execise.where(started_at: Date.today.all_month)
      schedule_text = "今月"
    elsif schedule.include?("来月")
      execise = Execise.where(started_at: Date.next_month.all_month)
      schedule_text = "来月"
    end

    return execise, schedule_text
  end

  def set_response(schedule)
    response = schedule + "の予定は　\n"
    self.each do |execise|
      response = response + execise.started_at.strftime("%m/%d-%H:%M") + "~ @" + execise.place.name + "\n"
    end
  end
end
