# frozen_string_literal: true

# Joke class
class Joke < ApplicationRecord
  before_validation :generate_content

  validates :content, presence: true
  validates :humour, presence: true
  validates :context, presence: true

  def generate_content
    return if content.present?

    self.content = JokeGenerator.perform(humour, context)
    raise 'Problem in Joke Generator' if content.blank?
  end
end
