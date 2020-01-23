require 'open-uri'
require 'nokogiri'


def get_townhall_names
  city_names = Array.new
  page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
  cities = page.xpath('//*[@class="lientxt"]')
  cities.each do |city|
    city_names << city.text
  end
  return city_names
end


def get_townhall_email
  townhall_email = Array.new
  get_townhall_urls.each do |link|
    page = Nokogiri::HTML(open(link))
    emails = page.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    emails.each do |email|
      townhall_email << email.text
    end
  end
  return townhall_email
end

def get_townhall_urls
  links = Array.new
  page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
  urls = page.xpath('//a[@class="lientxt"]')
  urls.each do |link|
    links << link[:href].chars.drop(1).join.sub(/\A(?!ga:)/, "https://www.annuaire-des-mairies.com")
  end
  return links
end

def hash_creation
  result = Hash[get_townhall_names.zip(get_townhall_email)]
  return result
end

def crypto_scrapper
  a = Array.new
  hash_creation.each do |city,email|
    new_hash = Hash.new
    new_hash[city] = email
    a << new_hash
  end
  p a
end

def perform
  get_townhall_names
  get_townhall_email
  get_townhall_urls
  hash_creation
  crypto_scrapper
end

perform