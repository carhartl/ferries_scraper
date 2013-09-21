module FerriesScraper
  class Scraper
    AVAILABLE_DEPARTURE_CITIES = %w( Dublin Liverpool ).freeze
    ROUTE_RFIDS = { Dublin: 18, Liverpool: 66 }.freeze
    DEFAULT_CONFIGURATION = {
      date: Time.now.to_date + 3,
      time: 12,
      age:  '18+',
    }.freeze

    attr_reader :configuration
    attr_reader :strategy

    def initialize(configuration)
      unless AVAILABLE_DEPARTURE_CITIES.include?(configuration[:departure])
        raise ArgumentError.new('Desired city not supported')
      end
      @configuration = DEFAULT_CONFIGURATION.merge(configuration)
      @strategy      = configuration[:strategy] || CapybaraEngine.new
    end

    def scrape
      @strategy.scrape(url, configuration)
    end

    private

    def url
      "/ferry/secure/multi_price_detail.aspx?stdc=DF10&grid=0&rfid=#{rfid}&psgr=1&curr=2&retn=False&rfidr=0"
    end

    def rfid
      ROUTE_RFIDS[configuration[:departure].to_sym]
    end
  end
end
