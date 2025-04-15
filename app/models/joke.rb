# frozen_string_literal: true

# Joke class
class Joke < ApplicationRecord
  validates :content, presence: true
  validates :humour, presence: true
  validates :context, presence: true
end
