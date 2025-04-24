# frozen_string_literal: true

# this is a class of jokes
class JokesController < ApplicationController
  def index
    render json: Joke.all
  end

  def random
    render json: Joke.all.sample
  end

  def show
    render json: Joke.find_by(id: params[:id])
  end

  def create
    joke = Joke.new(joke_params)
    if joke.save
      render json: joke, status: :created
    else
      render json: { message: 'Failed in creating joke', errors: joke.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    joke = Joke.find_by(id: params[:id])
    if joke.delete
      render json: joke, status: :ok
    else
      render json: { message: 'Sucide is not recommended, please reconsider' }, status: :no_content
    end
  end

  private

  def joke_params
    params.require(:joke).permit(:content, :humour, :context)
  end
end
