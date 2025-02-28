class Exercise < ApplicationRecord
  belongs_to :post, touch: true

  def self.search_for(schedule)
    if schedule.include?("今日")
      exercises = Exercise.where(started_at: Time.current.all_day).order(:started_at)
      schedule_text = "今日"
    elsif schedule.include?("明日")
      exercises = Exercise.where(started_at: Time.current.tomorrow.all_day).order(:started_at)
      schedule_text = "明日"
    elsif schedule.include?("今週")
      exercises = Exercise.where(started_at: Time.current.all_week).order(:started_at)
      schedule_text = "今週"
    elsif schedule.include?("来週")
      exercises = Exercise.where(started_at: Time.current.next_week.all_week).order(:started_at)
      schedule_text = "来週"
    elsif schedule.include?("今月")
      exercises = Exercise.where(started_at: Time.current.all_month).order(:started_at)
      schedule_text = "今月"
    elsif schedule.include?("来月")
      exercises = Exercise.where(started_at: Time.current.next_month.all_month).order(:started_at)
      schedule_text = "来月"
    end

    return exercises, schedule_text
  end

  def self.set_response(schedule)
    response = schedule + "の予定は"
    self.all.each do |exercise|
      response = response + "\n" + exercise.started_at.strftime("%m/%d(#{I18n.t('date.abbr_day_names')[exercise.started_at.wday]}) %H:%M") + "~ @" + exercise.place_name
    end

    response = response + "\nです！"
    return response
  end

  def self.search_for_days_after(setting_day)
    Exercise.where(started_at: Time.current.since(setting_day.days).all_day).order(:started_at)
  end

  def self.set_notification(setting_day)
    if setting_day == 0
      display_day = "今日"
    elsif setting_day == 1
      display_day = "明日"
    elsif setting_day == 2
      display_day = "明後日"
    else
      display_day = setting_day.to_s + "日後に"
    end
    response =  display_day + "りこばれがあります！"
    self.all.each do |exercise|
      response = response + "\n" + exercise.started_at.strftime("%m/%d(#{I18n.t('date.abbr_day_names')[exercise.started_at.wday]}) %H:%M") + "~ @" + exercise.place_name
    end
    return response
  end

  def date
    started_at.strftime('%F')
  end

  def start_time
    started_at.strftime('%R')
  end

  def end_time
    ended_at.strftime('%R')
  end
end
