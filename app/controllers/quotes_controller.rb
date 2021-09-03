class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :update, :destroy]

  # GET /quotes
  def index
    @quote = Quote.all

    render json: @quote
  end

  # GET /quotes/:tag
  def search
    searchTag = params[:tag]

    if findDB(searchTag).length > 0

    else
    end

    render json: {quotes: @quotes.quotes} 
  end

  def findDB(tag) 
    Tag.where(tag)
  end

  def resultFromDB(tag)
  end

  def crawlingTag
  end
end