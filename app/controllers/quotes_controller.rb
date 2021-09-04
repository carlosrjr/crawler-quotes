class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :update, :destroy]

  require_relative "../../lib/crawlers/quotes/crawler.rb"

  # GET /quotes
  def index
    @quote = Quote.all

    render json: { "quotes": @quote.as_json(:except => [ :_id ]) }
  end

  # GET /quotes/:tag
  def search
    tag = params[:tag]
    
    if not tag_exists?(tag)
      Crawlers::Quotes::Crawler.new.searchQuotes(tag)
    end
    
    @quotes = Quote.where(tags: tag)

    render json: { "quotes": @quotes.as_json(:except => [ :_id ]) }
  end

  private
    def tag_exists?(tag)
      Tag.where(title: tag).count > 0 ? true : false
    end
end