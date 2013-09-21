Feature: Ferry service scraping

	In order to apply for Waymate's Software Engineer (Transportation Data) position
	As a software engineer
	I want to build a beautiful and maintainable web scraper

	Scenario: Successfully scraping ferry departures
		Given the ferry website is available
		When I ask for ferries departing Dublin
		Then the results should be scraped from the site
		And the results should contain the desired attributes
