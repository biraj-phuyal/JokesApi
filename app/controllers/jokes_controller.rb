# frozen_string_literal: true

# this is a class of jokes
class JokesController < ApplicationController
  def index
    jokes = Joke.all
    render json: jokes
  end

  def random
    joke = Joke.all.sample
    render json: joke
  end

  def show
    joke = Joke.find_by(id: params[:id])
    render json: joke
  end

  def create
    joke = Joke.create(jokes_params)
    if joke.save
      render json: joke, status: :created
    else
      render json: { message: 'Failed to create the joke', erros: joke.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    joke = Joke.find_by(id: params[:id])
    if joke.delete
      render json: { message: 'Why did you delete your own kinds?' }, status: :ok
    else
      render json: { message: 'Sucide is not recommended, please reconsidered' }, status: :no_content
    end
  end

  private

  def jokes_params
    params.require(:joke).permit(:content, :humour, :context)
  end
end
