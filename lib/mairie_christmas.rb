require 'nokogiri'
require 'open-uri'

def find_URLs
page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
return page
end

def find_links(page)
townhall_links = page.css("a[class=lientxt]")
return townhall_links
end

def get_townhall_names (townhall_links)
  townhall_names = []
    townhall_links.each{ |url_end| townhall_names << "#{url_end.text.capitalize.gsub(" ","-")}" }
  return townhall_names
  end

def get_townhall_urls(townhall_links,page)
townhall_urls = []
  townhall_links.each{|urls| townhall_urls << "https://www.annuaire-des-mairies.com#{urls['href'].delete_prefix(".")}"}
return townhall_urls
end

def get_townhall_emails(townhall_urls)
townhall_emails = []
townhall_emails_clean = []
  townhall_urls.each do |urls|  
  page = Nokogiri::HTML(open("#{urls}"))
  townhall_emails = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
  townhall_emails.each { |mail| townhall_emails_clean << mail.text }
  end
return townhall_emails_clean
end

def townhall_array_of_hashes(townhall_names,townhall_emails_clean)
townhall_hash = Hash[townhall_names.zip(townhall_emails_clean)]
townhall_array_of_hashes = []
  townhall_hash.each {|key,value| townhall_array_of_hashes << { key => value }}
return townhall_array_of_hashes
end 


puts townhall_array_of_hashes(get_townhall_names(find_links(find_URLs)),get_townhall_emails(get_townhall_urls(find_links(find_URLs),find_URLs)))