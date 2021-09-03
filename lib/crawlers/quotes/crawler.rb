module Crawlers
  require 'nokogiri'
  require 'open-uri'
  
  module Quotes
    BASE_URL ="http://quotes.toscrape.com"
    
    class Crawler
      def searchQuotes(tag)

        url = "#{BASE_URL}/tag/#{tag}/"

        begin
          html = Nokogiri::HTML.parse(open(url))
          
          quotes = html.css('.quote')
          
          
          
          quotes.each do |quoteItem|
            quote = Quote.new
            
            puts "#########################################"
            quote.quote = quoteItem.css('.text').text
            quote.author = quoteItem.css('.author').text
            tagsQuote = quoteItem.css('.tag')
            quote.tags = []
            tagsQuote.each do |tagQuote|
              quote.tags << tagQuote.text
            end
            puts ">>>>>>>Quotes #{quote.quote}"
            
            quote.save
            puts "#########################################"
          end
        rescue
          return false
        end
        
        return true
      end

      def searchAuthor(url)
        puts ">>>>>>>>>> URL: #{url}"
      end
    end
  end
end