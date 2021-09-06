class QuotesController < ApplicationController

  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate
  before_action :set_quote, only: [:show, :update, :destroy]

  # GET /quotes
  def index
    quotes = Quote.all
    render json: quotes, root: 'quotes', adapter: :json, each_serializer: QuoteSerializer
  end

  # GET /quotes/:tag
  def search
    tag = params[:tag]
    
    if not tag_exists?(tag)
      Crawlers::Quotes::Crawler.new.search_quotes(tag)
    end
    
    quotes = Quote.where(tags: tag)
    render json: quotes, root: 'quotes', adapter: :json, each_serializer: QuoteSerializer
  end

  def clean
    Quote.delete_all
    render json: { Success: "Todos os quotes foram removidos." }
  end
  
  private
    def tag_exists?(tag)
      Tag.where(title: tag).count > 0 ? true : false
    end

    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        hmac_secret = 'In0va_M1nd!'
        JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
      end
    end
end