module FerriesScraper
  class Scraper
    AVAILABLE_DEPARTURE_CITIES = %w( Dublin Liverpool ).freeze
    ROUTE_RFIDS = { Dublin: 18, Liverpool: 66 }.freeze

    attr_reader :strategy

    def initialize(options)
      unless AVAILABLE_DEPARTURE_CITIES.include?(options[:departure])
        raise ArgumentError.new('Desired city not supported')
      end
      @strategy  = options[:strategy] || CapybaraEngine.new
      @departure = options[:departure]
    end

    def scrape
      @strategy.scrape(url)
    end

    private

    def url
      "/ferry/secure/multi_price_detail.aspx?stdc=DF10&grid=0&rfid=#{rfid}&psgr=1&curr=2&retn=False&rfidr=0"
    end

    def rfid
      ROUTE_RFIDS[@departure.to_sym]
    end
  end
end
