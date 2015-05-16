require 'scraperwiki'
require 'mechanize'


mechanize = Mechanize.new

page = mechanize.get('http://www.dublincity.ie/main-menu-your-council-your-city-councillors/full-councillor-list')

puts page.at('div#ctl00_PlaceHolderMain_ctl02__ControlWrapper_RichHtmlField tr')
