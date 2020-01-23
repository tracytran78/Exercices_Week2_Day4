require_relative '../lib/mairie_christmas.rb'

describe "the get townhall emails method" do
    it "should return a string" do
        expect(get_townhall_emails(get_townhall_urls(find_links(find_URLs),find_URLs))[0].class).to eq(String)
    end
    it "should return an email" do
        expect(get_townhall_emails(get_townhall_urls(find_links(find_URLs),find_URLs))[0].include?('@')).to eq(true)
    end
end

describe "the get_townhall_urls method" do
    it "should return an array" do
        expect(get_townhall_urls(find_links(find_URLs),find_URLs).class).to eq(Array)
    end
    it "should return URLs" do
        expect(get_townhall_urls(find_links(find_URLs),find_URLs)[0].include?('html')).to eq(true)
    end
    it "should return more than 3 URLs" do
        expect(get_townhall_urls(find_links(find_URLs),find_URLs).length > 3).to eq(true)
    end
end