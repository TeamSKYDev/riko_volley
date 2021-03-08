class Place < ApplicationRecord
  validates :name, presence:true, uniqueness: true

  acts_as_list
end
