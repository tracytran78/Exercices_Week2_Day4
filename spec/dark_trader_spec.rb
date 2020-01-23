require_relative '../lib/dark_trader.rb'


describe "the crypto_scrapper method" do
    it "should return an array" do
        expect(array_of_hashes(name_of_crypto(find_URL),price_of_crypto(find_URL)).class).to eq(Array)
    end
    it "should return an array of hashes" do
        expect(array_of_hashes(name_of_crypto(find_URL),price_of_crypto(find_URL))[0].class).to eq(Hash)
    end
    it "should be an entry called 'BTC'" do
        expect(array_of_hashes(name_of_crypto(find_URL),price_of_crypto(find_URL)).any? {|i| i['BTC']}).to eq(true)
    end
    it "should be an entry called 'ETH'" do
        expect(array_of_hashes(name_of_crypto(find_URL),price_of_crypto(find_URL)).any? {|i| i['ETH']}).to eq(true)
    end
    it "should be more than 20 entries" do
        expect(array_of_hashes(name_of_crypto(find_URL),price_of_crypto(find_URL)).length > 20).to eq(true)
    end
    it "should return float in values" do
        expect(array_of_hashes(name_of_crypto(find_URL),price_of_crypto(find_URL))[0].fetch("BTC").class).to eq(Float)
    end
end