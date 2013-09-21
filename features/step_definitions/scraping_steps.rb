Given(/^the ferry website is available$/) do
  # Nothing to do here yet, but keep for readability.
  # For Mechanize we had to stub some requests here,
  # using Webmock for instance.
end

When(/^I ask for ferries departing Dublin$/) do
  scraper = FerriesScraper::Scraper.new(departure: 'Dublin')
  @results = scraper.scrape
end

Then(/^the results should be scraped from the site$/) do
  @results.each do |itinerary|
    %w( route_name origin_name destination_name departure_time arrival_time duration price ).each do |attribute|
      itinerary[attribute].should_not be_empty
    end
  end
end

Then(/^the results should contain the desired values$/) do
  @results.size.should eq(6)
  @results.first.tap do |itinerary|
    itinerary['route_name'].should eq('Dublin - Holyhead : Irish Ferries')
    itinerary['origin_name'].should eq('Dublin')
    itinerary['destination_name'].should eq('Holyhead')
    itinerary['departure_time'].should eq('Thu 19 Sep 14:30')
    itinerary['arrival_time'].should eq('Thu 19 Sep 16:30')
    itinerary['duration'].should eq('02h 00m')
    itinerary['price'].should eq('£41.50')
  end
end

Given(/^network is available$/) do
  Capybara.app_host = FerriesScraper::BASE_URL
end
