# FerriesScraper

## Usage:

Install gems:
  
    $ bundle
  
Scrape and save results as JSON:

    $ bundle exec rake scrape departure=Dublin
  
Supported cities: Dublin, Liverpool. The results are saved as JSON in the `scraped` directory.
  
## Testing

Run all tests:

    $ bundle exec rake
  
Start guard for continuous testing:

    $ bundle exec guard
  
## Testing against real site

Useful for testing whether site has changed and scraping needs to be adapted:

    $ bundle exec cucumber -p online
