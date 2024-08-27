class Api::V0::MarketsController < ApplicationController
  def index
  end

  def show 
    render json: Book.find(params[:id])
  end
end