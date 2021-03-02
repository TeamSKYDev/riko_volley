class Post < ApplicationRecord
  has_many :exercises
  accepts_nested_attributes_for :exercises

  belongs_to :user
end
