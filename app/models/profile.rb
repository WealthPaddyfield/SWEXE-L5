class Profile < ApplicationRecord
  belongs_to :user

  validates :display_name, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 1000 }, allow_blank: true
  validates :website, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true
end
