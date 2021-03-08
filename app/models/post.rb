class Post < ApplicationRecord
  has_many :exercises, dependent: :destroy
  accepts_nested_attributes_for :exercises

  belongs_to :user

  validates :title, presence:true
end
