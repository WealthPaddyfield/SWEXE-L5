class Profile < ApplicationRecord
  belongs_to :user

  validates :display_name, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 1000 }, allow_blank: true
end
