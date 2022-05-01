class User < ApplicationRecord
  has_many :repos, dependent: :destroy

  validates :login, presence: true
end
