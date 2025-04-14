class Joke < ApplicationRecord
    validates :content, presence: true
    validates :humour, presence: true
    validates :context, presence: true
end
