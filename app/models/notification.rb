class Notification < ApplicationRecord
  validates :days_before, presence:true
end
