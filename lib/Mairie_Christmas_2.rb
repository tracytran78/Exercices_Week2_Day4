require 'nokogiri'
require 'open-uri'
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
townhall_links = page.css("a[class=lientxt]")
townhall_array = []
townhall_links.each{ |url_end| townhall_array << "https://www.annuaire-des-mairies.com#{url_end['href'].delete_prefix(".")}" }

townhall_name_array = []
townhall_links.each{ |url_end| townhall_name_array << "#{url_end.text}" }

# puts townhall_name_array
# puts townhall_array


townhall_mail_clean = []
townhall_array.each do |url_end|
 page = Nokogiri::HTML(open("#{url_end}"))
 townhall_mail_raw = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
 townhall_mail_raw.each { |mail| townhall_mail_clean << mail.text }
end
hash = Hash.new
townhall_name_array.each_with_index do |e, i|
    hash[e] = townhall_mail_clean[i]
end
mail_hash_array = []
    hash.each {|k,v| mail_hash_array << {k => v}}
    puts mail_hash_array