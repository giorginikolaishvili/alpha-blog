class Article < ApplicationRecord
    belongs_to :user
validates :title, presence: true, length: {minimum: 3, maximum: 20}
validates :user_id, presence:true
end