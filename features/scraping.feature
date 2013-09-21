Feature: Ferry service scraping

	In order to apply for Waymate's Software Engineer (Transportation Data) position
	As a software engineer
	I want to build a beautiful and maintainable web scraper

	Scenario: Successfully scraping ferry departures
		Given the ferry website is available
		When I ask for ferries departing Dublin
		Then the results should be scraped from the site
		And the results should contain the desired values

	# Also a handy way to test whether there had been changes on the site,
	# and it could run regularly on a CI server...
	@online
	Scenario: Scraping the site
		Given network is available
		When I ask for ferries departing Dublin
		Then the results should be scraped from the site
