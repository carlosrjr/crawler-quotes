module Crawlers
  require 'nokogiri'
  require 'rest-client'
  
  module Quotes
    # URL base para obter os quotes
    BASE_URL ="http://quotes.toscrape.com"
    
    class Crawler
      # Method utilizado para fazer o scrapping dos quotes.
      def search_quotes(tag, page=1, quotes_list=[])
        url = "#{BASE_URL}/tag/#{tag}/page/#{page}/"
        
        if page == 1
          quotes_list = []
        end

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

            quotes_list << q
          end
          
          if has_next?(doc)
            search_quotes(tag, page+1, quotes_list)
          else
            if quotes_list.length == 0
              return false
            else
              
              quotes_list.map do |q|
                q.save
              end
              
              t = Tag.new
              t.title = tag
              t.register_date = DateTime.now
              t.save
            end

          end
        rescue
          puts "Ocorreu um erro!"
          return false
        end
        
        return true
      end
      
      private
        def has_next?(doc)
          begin
            doc.css('.next a').first['href']
            return true
          rescue
            return false
          end
        end
    end
  end
end