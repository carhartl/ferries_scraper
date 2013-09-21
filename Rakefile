$:.unshift 'lib'

require 'rubygems'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec) do |task|
end

Cucumber::Rake::Task.new(:cucumber) do |task|
end

task default: [:spec, :cucumber]

task :scrape => ['scraped'] do |task|
  require 'ferries_scraper'

  verbose(false)

  if ENV['departure']
    scraper = FerriesScraper::Scraper.new(departure: ENV['departure'])
    puts 'Scraping...'
    @results = scraper.scrape
    cd 'scraped'
    file_name = "#{ENV['departure']}_#{scraper.strategy.send(:days_in_advance_from_today).gsub(/\s/, '_')}.json".downcase
    open(file_name, 'w') { |f| f << @results.to_json }
    puts "Finished! File saved as #{file_name}"
  else
    puts "Please specify a departure, example: 'rake scrape departure=Dublin'"
  end
end

directory 'scraped'
