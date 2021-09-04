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

    if not has_tag(tag)
      puts "ENTROUU AQUI <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      Crawlers::Quotes::Crawler.new.searchQuotes(tag)
    end

    render json: { quotes: filterQuotes(tag) }
  end

  private
    def has_tag(tag)
      tags = Tag.all

      tags.each do |tagItem| 
        if tagItem.title == tag
          puts ">>>>>>>>> Já Existe"
          return true
        end
      end

      puts ">>>>>>>>> Não Existe"
      
      return false
    end

    def filterQuotes(tag)
      quotes = Quote.all

      filtered = []
      quotes.each do |quote|
        if quote.tags.include? tag
          filtered << quote
        end
      end

      filtered
    end

end