require 'scraperwiki'
require 'mechanize'


mechanize = Mechanize.new

page = mechanize.get('http://www.dublincity.ie/main-menu-your-council-your-city-councillors/full-councillor-list')
page_urls = page.search('div#ctl00_PlaceHolderMain_ctl02__ControlWrapper_RichHtmlField a')

page_urls.links.each do |con_link|
  puts con_link.text
end


