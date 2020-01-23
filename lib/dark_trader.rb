require 'open-uri'
require 'nokogiri'

$page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def crypto_names
  crypto_names = $page.xpath('//*[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol"]')
  crypto_names_2 = Array.new
  crypto_names.each do |name|
    crypto_names_2 << name.text
  end
  return crypto_names_2
end

def crypto_rates
  crypto_rates = $page.xpath('//*[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]')
  crypto_rates_2 = Array.new
  crypto_rates.each do |rate|
    crypto_rates_2 << rate.text
  end
  crypto_rates_2 = crypto_rates_2.map { |rate| rate.delete "$" }
  return crypto_rates_2
end

def hash_creation
  result = Hash[crypto_names.zip(crypto_rates)]
  return result
end

def crypto_scrapper
  a = Array.new
  hash_creation.each do |name,rate|
    new_hash = Hash.new
    new_hash[name] = rate
    a << new_hash
  end
  p a
end

def perform
  crypto_names
  crypto_rates
  hash_creation
  crypto_scrapper
end

perform








