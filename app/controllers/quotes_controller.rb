class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :update, :destroy]

  require 'nokogiri'
  require 'open-uri'

  BASE_URL ="http://quotes.toscrape.com"

  # GET /quotes
  def index
    @quote = Quote.all

    render json: @quote
  end

  # GET /quotes/:tag
  def search
    tag = params[:tag]
    
    if findTagDB(tag).length == 0
      startCrawler(tag)
    end

    render json: { quotes: findTagDB(tag) } 
  end

  private 
    def findTagDB(tag) 
      Tag.where(tag)
    end

    def startCrawler(tag)
      url = "#{BASE_URL}/tag/#{tag}/"
      begin
        html = Nokogiri::HTML.parse(open(url))
      rescue
        return false
      end
      
      quotes = html.css('.quote')
      
      
      quotes.each do |quoteItem|
        quote = Quote.new
        
        puts "#########################################"
        #puts "#{quoteItem}"
        quote.quote = quoteItem.css('.text').text
        quote.author = quoteItem.css('.author').text
        #aboutAuthor = 
        tagsQuote = quoteItem.css('.tag')
        quote.tags = []
 
        tagsQuote.each do |tagQuote|
          quote.tags << tagQuote.text
        end

        puts "#{quote.tags}"
        puts "#########################################"
      end

    end

    def resultFromDB(tag)
      result
    end
end