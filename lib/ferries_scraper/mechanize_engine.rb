module FerriesScraper

  # Scraping engine without JavaScript support
  #
  class MechanizeEngine
    # When running into issues with ssl certificate verification on OSX:
    # $ brew install curl-ca-bundle
    # $ gem install certified
    # See http://stackoverflow.com/questions/10728436/opensslsslsslerror-ssl-connect-returned-1-errno-0-state-sslv3-read-server-c

    # require 'certified'
    # require 'mechanize'
    # agent = Mechanize.new
    # page = agent.get('https://ssl.directferries.com/ferry/secure/multi_price_detail.aspx?stdc=DF10&grid=0&rfid=18&psgr=1&curr=2&retn=False&rfidr=0')
    # form = page.forms[0]
    # form.cal_out = '19 September 2013'
    # form.radiobuttons_with(:name => 'vehicleDetails$HasVehicle')[0].check
    # form.field_with(:name => 'passengerAges$Age1$ddlAges').options[1].select
    # page = agent.submit(form, form.buttons.last) # hitting error on first post, need to submit a second time
    # # page.search('.error_txt')
    # form = page.forms[0]
    # form.field_with(:name => 'ddOutTime').options[13].select
    # page = agent.submit(form, form.buttons.last)
    # # page.search('.error_txt')
  end
end
