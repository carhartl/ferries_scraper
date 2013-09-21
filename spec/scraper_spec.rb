require 'spec_helper'

describe FerriesScraper::Scraper do
  let(:strategy) { double }

  describe "Configuration for desired departure city" do
    it "allows Dublin" do
      expect { FerriesScraper::Scraper.new(departure: 'Dublin', strategy: strategy) }.
        not_to raise_error
    end

    it "allows Liverpool" do
      expect { FerriesScraper::Scraper.new(departure: 'Liverpool', strategy: strategy) }.
        not_to raise_error
    end

    it "won't allow other cities" do
      expect { FerriesScraper::Scraper.new(departure: 'Holyhead', strategy: strategy) }.
        to raise_error(ArgumentError)
    end
  end

  describe "Configuration for scraping strategy" do
    it "injects scraping strategy" do
      FerriesScraper::Scraper.new(departure: 'Dublin', strategy: strategy).strategy.should be(strategy)
    end
  end

  describe "#scrape" do
    subject { FerriesScraper::Scraper.new(departure: 'Dublin', strategy: strategy) }

    let(:result) { [] }

    before(:each) do
      strategy.stub(scrape: result)
    end

    it "returns an array with the results" do
      subject.scrape.should eq(result)
    end

    it "scrapes the correct url for the given departure city" do
      FerriesScraper::Scraper::ROUTE_RFIDS.each do |city, id|
        scraper = FerriesScraper::Scraper.new(departure: "#{city}", strategy: strategy)
        strategy.should_receive(:scrape).with("/ferry/secure/multi_price_detail.aspx?stdc=DF10&grid=0&rfid=#{id}&psgr=1&curr=2&retn=False&rfidr=0")
        scraper.scrape
      end
    end
  end
end
