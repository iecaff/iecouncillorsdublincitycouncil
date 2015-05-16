require 'scraperwiki'
require 'mechanize'


mechanize = Mechanize.new

front_page = mechanize.get('http://www.dublincity.ie/main-menu-your-council-your-city-councillors/full-councillor-list')
page_urls = front_page.search('div#ctl00_PlaceHolderMain_ctl02__ControlWrapper_RichHtmlField a')

page_urls.each do |con_link|
      con_page = Mechanize::Page::Link.new( con_link, mechanize, front_page ).click
     image_url = con_page.at('div#eventDetails img')['src']
     con_image = front_page.uri.merge image_url.uri
     puts con_image
  
end


