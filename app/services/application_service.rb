# frozen_string_literal: true

# this is application service class
class ApplicationService
  def self.perform(*args, &block)
    new(*args, &block).perform
  end
end
