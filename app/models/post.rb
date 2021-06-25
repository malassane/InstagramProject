class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 140}
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  mount_uploader :avatar, ImageUploader


end
