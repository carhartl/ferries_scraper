require 'ferries_scraper'

Capybara.app_host = 'http://localhost:9999'

require 'childprocess'
require 'timeout'
require 'open-uri'
server = ChildProcess.build('rackup', '--port', '9999')
server.start
Timeout.timeout(3) do
  loop do
    begin
      open('http://localhost:9999/ferry/secure/multi_price_detail.aspx')
      break
    rescue Errno::ECONNREFUSED => try_again
      sleep 0.1
    end
  end
end

at_exit do
  server.stop
end
