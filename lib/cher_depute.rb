require 'nokogiri'
require 'open-uri'

def find_URL
page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")) 
return page
end

def get_depute_name(page)
name = page.xpath('//*[@id="deputes-list"]/div/ul/li/a')
return name.text
end

def get_depute_email(depute_url)
    page = Nokogiri::HTML(open(depute_url))
    email = page.xpath("/html/body/div/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a").text
    return email
end

def get_depute_urls
    page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
    urls = []
    page.xpath("//*[contains(@id, 'deputes-list')]//@href").each do |i|
        urls << "http://www2.assemblee-nationale.fr" + i
    end
    return urls
end

get_depute_name (find_URL)
get_depute_urls.each_index {|i| puts get_depute_email(get_depute_urls[i])}