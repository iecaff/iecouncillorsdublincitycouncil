require 'scraperwiki'
require 'mechanize'


mechanize = Mechanize.new

front_page = mechanize.get('http://www.dublincity.ie/main-menu-your-council-your-city-councillors/full-councillor-list')
page_urls = front_page.search('div#ctl00_PlaceHolderMain_ctl02__ControlWrapper_RichHtmlField a')
con_info = ['Area:','Ward:','Elected:','Party:','Address:','Email:','Phone:','Mobile:','Fax:',nil]

page_urls.each do |con_link|
      con_page = Mechanize::Page::Link.new( con_link, mechanize, front_page ).click
       if con_page.at('picture img')
         image_url = con_page.at('picture source')['srcset'].gsub(/\s.+/, '')
       else
        image_url = con_page.at('div#textContent img')['src']
  end
     con_image = con_page.uri.merge image_url
     puts con_image
     con_name = con_page.search('h1').text
     con_nodes = con_page.search("div[class='node node-article clearfix']//text()")
     con_text=con_nodes.map(&:text).delete_if{|x| x !~ /\w/}
     con_text.each_with_index do |con_string,i|
           if con_info.include? con_text[i+1]
             #    puts 'blank'
           else
                 case con_string
      when 'Area:' 
       puts 'Area: ' + con_text[i+1]
       con_area = con_text[i+1]  
      when 'Ward:' 
      puts 'Ward: ' + con_text[i+1]   
      con_ward = con_text[i+1]   
      when 'Elected:' 
    #  puts 'Elected: ' + con_text[i+1]      
      when 'Party:' 
       puts 'Party: ' + con_text[i+1]   
       con_party = con_text[i+1]   
      when 'Address:' 
      puts 'Address: ' + con_text[i+1] 
      con_address = con_text[i+1]   
      when 'Email:' 
      puts 'Email: ' + con_text[i+1]  
      con_email = con_text[i+1]   
      when 'Phone:' 
      puts 'Phone: ' + con_text[i+1]   
      con_phone = con_text[i+1]   
      when 'Mobile:'
      puts 'Mobile: ' + con_text[i+1] 
      con_mobile = con_text[i+1]   
      when 'Fax:' 
   #   puts 'Fax: ' + con_text[i+1]
      else
          #  puts "blank"
end

con_record = {
:auth =>     con_area.to_s,
:lea 	=>     con_ward.to_s,
:name =>	con_name.to_s,
:party =>	con_party.to_s,
:email =>	con_email.to_s,
:phone =>	con_phone.to_s,
:mobile =>	con_mobile.to_s,
:image =>	con_image.to_s,
:address => con_address.to_s
}

  end
  ScraperWiki.save_sqlite([:name], con_record)
  end          
     
end




