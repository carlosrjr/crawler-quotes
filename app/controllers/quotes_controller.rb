class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :update, :destroy]

  require_relative "../../lib/crawlers/quotes/crawler.rb"

  # GET /quotes
  def index
    @quote = Quote.all

    render json: @quote
  end

  # GET /quotes/:tag
  def search
    tag = params[:tag]

    Crawlers::Quotes::Crawler.new.searchQuotes(tag)

    render json: { quotes: Quote.all } 
  end

end