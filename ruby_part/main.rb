require 'net/http'
require 'nokogiri'
require 'date'

url = "https://agriculture.house.gov/news/documentsingle.aspx?DocumentID=2106"
uri = URI.parse(url)

response = Net::HTTP.get_response(uri)
html_doc = Nokogiri::HTML(response.body)

location, date = html_doc.css('div.topnewstext').text.split(',').map(&:strip)

result = { title: html_doc.css('h2.newsie-titler').text,
           date: Date.parse(date).strftime('%Y-%m-%d'),
           location: location,
           article: html_doc.css('div.bodycopy').text}

puts result
