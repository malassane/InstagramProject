class Profile < ApplicationRecord
    belongs_to :user
    mount_uploader :picture, ImageUploader
end
