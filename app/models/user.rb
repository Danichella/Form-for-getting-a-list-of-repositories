class User < ApplicationRecord
    has_many :repos, dependent: :destroy

    validates :name, :login, presence:true
end
