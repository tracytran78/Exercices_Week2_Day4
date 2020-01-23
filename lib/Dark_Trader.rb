require 'nokogiri'
require 'open-uri'

def find_URL
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/95"))
return page
end

def name_of_crypto (page)
crypto_names = []
  names = page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/div/table/tbody/tr/td[3]').each do |symbol|
  crypto_names << symbol.text
  end
return crypto_names 
end

def price_of_crypto (page)
crypto_prices = []
  values = page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/div/table/tbody/tr/td[5]').each do |price|
  crypto_prices << price.text
  end
return crypto_prices
end

def array_of_hashes (crypto_names, crypto_prices)
crypto_hash = Hash[crypto_names.zip(crypto_prices)]
crypto_array_of_hashes = []
crypto_hash.each {|key,value| crypto_array_of_hashes << { key => value.delete_prefix("$").to_f }}
return crypto_array_of_hashes
end 

puts array_of_hashes(name_of_crypto(find_URL),price_of_crypto(find_URL))