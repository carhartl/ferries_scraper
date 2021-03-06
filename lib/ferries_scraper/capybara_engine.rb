require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { js_errors: false })
end
Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.app_host = FerriesScraper::BASE_URL
Capybara.configure do |config|
  config.match = :first
end


module FerriesScraper

  # Scraping engine with JavaScript support
  #
  class CapybaraEngine
    include Capybara::DSL

    def scrape(url, options)
      @results ||= query_results(url, options)
    end

    private

    def query_results(url, options)
      visit url
      fill_in_date(date_formatted(options[:date]))
      choose_time(options[:time])
      choose_age(options[:age])
      choose_vehicle
      submit_form
      wait_for_results
      parse_results
    rescue Capybara::ElementNotFound => e
      # Notify a developer here...
      puts "The site's HTML probably has changed: #{e}"
    end

    def fill_in_date(date)
      # Make sure the element is on the page, before we access it via JavaScript
      find 'input[name=cal_out]'
      # Capybara's `fill_in` won't work with readonly inputs
      page.execute_script %{ document.querySelector('input[name=cal_out]').value = '#{date}'; }
    end

    def choose_time(time)
      # By submitting once when necessary we get to time we want to enter
      submit_form unless has_desired_time?(time)
      select "#{time}:00", from: 'ddOutTime'
    end

    def choose_age(age)
      select age, from: 'passengerAges_Age1_ddlAges'
    end

    def choose_vehicle
      # Make sure the element is on the page, before we access it via JavaScript
      find 'input[name="vehicleDetails$HasVehicle"]'
      # `choose 'vehicleDetails_radNoVehicle'` blows up the form when testing locally because of onclick
      page.execute_script %{ document.querySelector('input[name="vehicleDetails$HasVehicle"]').checked = true; }
    end

    def submit_form
      click_button 'butSubmit'
    end

    def has_desired_time?(time)
      page.has_css?("#ddOutTime option[value='#{time}']")
    end

    def wait_for_results
      find('div.ticket')
    end

    def parse_results
      # Each itinerary in the output should contain the following attributes:
      # route_name, origin_name, destination_name, departure_time, arrival_time, duration, price.
      #
      # Only pick those with a price - since we chose "no vehicle" some entries are useless:
      # "This operator does not currently support foot passengers on this route.", others
      # may simply lack sufficient data ("The operator failed to return a price. ...").
      all('div.ticket').map do |div|
        next if div.find('.pricetxt').text.strip.empty?

        {
          'route_name'       => div.find('.ticket_header p').text,
          'origin_name'      => div.find('.info1 .porttxt').text,
          'destination_name' => div.find('.info2 .porttxt').text,
          'departure_time'   => clean_scraped_time(div.find('.info1 .porttxt + p').text),
          'arrival_time'     => clean_scraped_time(div.find('.info2 .porttxt + p').text),
          'duration'         => div.find('.duration p').text,
          'price'            => div.find('.pricetxt').text,
        }
      end.compact
    end

    def clean_scraped_time(text)
      text.gsub(/\A[^:]+:/, '').gsub(/@/, '').gsub(/\s+/, ' ').strip
    end

    def date_formatted(date)
      date.strftime('%e %B %Y').strip
    end
  end
end
