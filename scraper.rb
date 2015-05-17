require 'scraperwiki'
require 'mechanize'


mechanize = Mechanize.new

front_page = mechanize.get('http://www.dublincity.ie/main-menu-your-council-your-city-councillors/full-councillor-list')
page_urls = front_page.search('div#ctl00_PlaceHolderMain_ctl02__ControlWrapper_RichHtmlField a')
con_info = ['Area:','Ward:','Elected:','Party:','Address:','Email:','Phone:','Mobile:','Fax:']

page_urls.each do |con_link|
      con_page = Mechanize::Page::Link.new( con_link, mechanize, front_page ).click
       if con_page.at('picture img')
         image_url = con_page.at('picture source')['srcset'].gsub(/\s.+/, '')
       else
        image_url = con_page.at('div#textContent img')['src']
  end
     con_image = con_page.uri.merge image_url
     puts con_image
     
     con_nodes = con_page.search("div[class='node node-article clearfix']//text()")
     con_text=con_nodes.map(&:text).delete_if{|x| x !~ /\w/}
     con_text.each_with_index do |con_string,i|
                 case con_string
      when 'Area:' AND con_info.has? con_text[i+1]
       puts 'Area: ' + con_string
      when 'Ward:' AND con_info.has? con_text[i+1]
      puts 'Ward: ' + con_string     
      when 'Elected:' AND con_info.has? con_text[i+1]
      puts 'Elected: ' + con_string      
      when 'Party:' AND con_info.has? con_text[i+1]
       puts 'Party: ' + con_string      
      when 'Address:' AND con_info.has? con_text[i+1]
      puts 'Address: ' + con_string     
      when 'Email:' AND con_info.has? con_text[i+1]
      puts 'Email: ' + con_string      
      when 'Phone:' AND con_info.has? con_text[i+1]
      puts 'Phone: ' + con_string      
      when 'Mobile:' AND con_info.has? con_text[i+1]
      puts 'Mobile: ' + con_string     
      when 'Fax:' AND con_info.has? con_text[i+1]
      puts 'Fax: ' + con_string
      else
            puts "blank"
end

  end
            
     
end




