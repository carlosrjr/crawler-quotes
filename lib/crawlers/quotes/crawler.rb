module Crawlers
  require 'nokogiri'
  require 'rest-client'
  
  module Quotes
    # URL base para obter os quotes
    BASE_URL ="http://quotes.toscrape.com"
    
    class Crawler
      # Method utilizado para fazer o scrapping dos quotes.
      def searchQuotes(tag, page=1)
        url = "#{BASE_URL}/tag/#{tag}/page/#{page}/"
        
        begin
          html = RestClient.get(url)
          doc = Nokogiri::HTML.parse(html)

          quotes = doc.css('.quote')
          
          quotes.each do |quoteItem|
            q = Quote.new
            
            q.quote = quoteItem.css('.text').text
            q.author = quoteItem.css('.author').text
            q.author_about = "#{BASE_URL}#{quoteItem.css('a')[0]['href']}"
            tagsQuote = quoteItem.css('.tag')
            q.tags = []
            tagsQuote.each do |tagQuote|
              q.tags << tagQuote.text
            end

            q.save
          end

          t = Tag.new
          t.title = tag
          t.save
        rescue
          puts ">>>>>> FALHOU!"
          return false
        end
        
        return true
      end
    end
  end
end