$:.unshift(File.join(File.dirname(__FILE__), '..', 'ext'))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'curb'
require 'mysql'
require 'nokogiri'
require 'net/http'
require 'net/ping'

puts "Enter a value of URL :"
str = gets
@doc = Nokogiri::HTML(open(str.to_s))
fdoc = @doc.css('table')[3].css('tr')
sdoc = @doc.css('table')[4].css('tr')
i=0
fdoc.each {|f| 
  i+=1
  File.open('iata_airlines.txt', 'a'){ |file| file.puts ';'+f.css('td')[0].text.to_s+';'+f.css('td')[1].text.to_s+';'+f.css('td')[2].text.to_s+';'+f.css('td')[3].text.to_s+';'+f.css('td')[4].text.to_s+';'+f.css('td')[5].text.to_s+';'+f.css('td')[6].text.to_s+';'+f.css('td')[7].text.to_s+';'} if i>1
}
k=0
sdoc.each {|f|
  k+=1
  File.open('iata_airlines.txt', 'a'){ |file| file.puts ';'+f.css('td')[0].text.to_s+';'+f.css('td')[1].text.to_s+';'+f.css('td')[2].text.to_s+';'+f.css('td')[3].text.to_s+';'+f.css('td')[4].text.to_s+';'+f.css('td')[5].text.to_s+';'+f.css('td')[6].text.to_s+';'+f.css('td')[7].text.to_s+';'} if k>1
}

