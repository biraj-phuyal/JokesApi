# frozen_string_literal: true

# this is a class of jokes
class JokesController < ApplicationController
  def index
    @jokes = Joke.all
    render json: @joke
  end

  def show
    @joke = Joke.find_by(id: params[:id])
    render json: @joke
  end

  def create
    @joke = Joke.create(jokes_params)
    if joke.save
      render json: { message: 'A joke has been created' }, status: :success
    else
      render json: { message: 'Failed to create the joke' }, status: :unsuccessful
    end
  end

  private

  def jokes_params
    require(:joke).permit(:content, :homour, :context)
  end
end
