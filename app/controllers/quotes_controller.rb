class QuotesController < ApplicationController

  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate
  before_action :set_quote, only: [:show, :update, :destroy]

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

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      hmac_secret = 'In0va_M1nd!'
      JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
    end
  end

  private
    def tag_exists?(tag)
      Tag.where(title: tag).count > 0 ? true : false
    end
end