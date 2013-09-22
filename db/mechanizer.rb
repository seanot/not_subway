require 'rubygems'
require 'mechanize'
# require './noko_test.rb'


class Mechanizer

  attr_reader :link_names, :restaurants

  def initialize(url)
    @agent = Mechanize.new
    @url = url
    @link_names = []
    @page = @agent.get(@url)
    gather_link_names
    filter_link_names
    @restaurants = []
    visit_restaurant_page
  end

  def gather_link_names
    @page.links.each do |link|
      @link_names << link.text
    end
  end

  def filter_link_names
    @link_names.keep_if { |obj| obj.match(/^\d+.+/) }
  end

  def visit_restaurant_page
    @link_names.each do |link|
      agent = Mechanize.new
      page = agent.get(@url)
      p link
      page = agent.page.link_with(:text => link).click
      page = agent.page.link_with(:text => "Menu").click
      noko = Nokogirize.new(page)
      noko.page = ''
      @restaurants << noko
      p @restaurants
    end
  end

end



# rn1 = Mechanizer.new('http://chicago.menupages.com/restaurants/all-areas/river-north/all-cuisines/')

# p rn1.restaurants
