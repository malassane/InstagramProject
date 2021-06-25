class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
                     before_validation { email.downcase! }
                    has_secure_password
                    validates :password, presence: true, length: { minimum: 6 }
                    has_many :posts
                    has_many :favorites, dependent: :destroy

                    mount_uploader :avatar1, ImageUploader

                  #  has_many :profiles
                    has_one :profile, dependent: :destroy
end
