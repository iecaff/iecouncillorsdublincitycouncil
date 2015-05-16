require 'scraperwiki'
require 'mechanize'


mechanize = Mechanize.new

front_page = mechanize.get('http://www.dublincity.ie/main-menu-your-council-your-city-councillors/full-councillor-list')
page_urls = front_page.search('div#ctl00_PlaceHolderMain_ctl02__ControlWrapper_RichHtmlField a')

page_urls.each do |con_link|
      con_page = Mechanize::Page::Link.new( con_link, mechanize, front_page ).click
       if con_page.at('picture img')
         image_url = con_page.at('picture source')['srcset'].gsub(/\s.+/, '')
       else
        image_url = con_page.at('div#textContent img')['src']
  end
     con_image = con_page.uri.merge image_url
     puts con_image
     
     if con_page.at("strong:contains('Ward')").next.next.text
     con_ward = con_page.at("strong:contains('Ward')").next.next.text
     puts con_ward
     end
     if con_page.at("strong:contains('Email')").next.nil?
     con_email = con_page.at("strong:contains('Email')").parent.next_element.at('a').text
          puts con_email
     else     
     con_email = con_page.at("strong:contains('Email')").next.next.text
     puts con_email
     end
          if con_page.at("strong:contains('Area')").next.next.text
     con_area = con_page.at("strong:contains('Area')").next.next.text
     puts con_area
     end
     if con_page.at("strong:contains('Phone')").parent.text
     con_phone = ""
     elsif con_page.at("strong:contains('Phone')").next.next.text
     con_phone = con_page.at("strong:contains('Phone')").next.next.text
     puts con_phone
     end
          if con_page.at("strong:contains('Mobile')").next.next.text
     con_mobile = con_page.at("strong:contains('Mobile')").next.next.text
     puts con_mobile
     end
          if con_page.at("strong:contains('Party')").next.next.text
     con_party = con_page.at("strong:contains('Party')").next.next.text
     puts con_party
     end
     if con_page.at("strong:contains('Address')").next.nil?
           con_address = con_page.at("strong:contains('Address')").parent.next.text
     puts con_address
     else
     con_address = con_page.at("strong:contains('Address')").next.next.text
     puts con_address
     end
end

