require 'nokogiri'
require 'open-uri'
# require 'mechanize'

# Get a Nokogiri::HTML::Document for the page we’re interested in...

# doc = Nokogiri::HTML(open('http://chicago.menupages.com/restaurants/orange-6/menu'))

#   Do funky things with it using Nokogiri::XML::Node methods...

class Nokogirize
  
  attr_accessor :page
  attr_reader :average_price, :address, :zip, :name

  def initialize(page)
    @page = page
    @name = ''
    @average_price = ''
    @address = ''
    @zip = ''
    nokogirize
  end

  def nokogirize
    prices = []

    @page.search(".prices-three").each do |table|
        table.search('td').each do |cell|
        prices.push(cell.content.lstrip)
      end
    end

    prices

    prices.keep_if { |x| x.include?('.') }

    prices.map! { |str| str.match(/\d*\.\d{2}/)[0].to_f }

    @name = @page.search('.title1respage').last.content
    @average_price = (prices.inject(:+) / prices.length).round(2)
    @address = @page.search('.addr').last.content
    @zip = @page.search('.postal-code').last.content
  end

end

# agent = Mechanize.new
# page = agent.get('http://chicago.menupages.com/restaurants/all-areas/river-north/all-cuisines/')
# page = agent.page.link_with(:text => "18Bar Louie").click
# page = agent.page.link_with(:text => "Menu").click
# noko = Nokogirize.new(page)
# p noko.average_price
# p noko.address
# p noko.zip
# p noko.name


# p doc.css('.addr').last.content
# p doc.css('.postal-code').last.content
# p (prices.inject(:+) / prices.length).round(2)

