class Place < ApplicationRecord
  has_many :exercises

  validates :name, presence:true, uniqueness: true

  acts_as_list
end
