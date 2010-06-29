require 'rubygems'
require 'sinatra'
require 'active_record'
require 'geokit'
require 'json'
require 'rack/contrib/jsonp'
require 'lib/acts_as_mappable'
use Rack::JSONP

dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig['production']

configure do
  LOGGER = Logger.new("sinatra.log") 
  ActiveRecord::Base.logger = LOGGER
end
 
helpers do
  def logger
    LOGGER
  end
end

class Waypoint < ActiveRecord::Base
  acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude
end

get '/' do
  {:foo => 'bar', :meh => true}.to_json
end

get '/nearby' do
  @points = Waypoint.find(:all, :origin => [44.0559,-121.31], :within => 5)
  content_type :json
  @points.to_json
end

get '/new' do
  a = {
    :title => params[:title],
    :description => params[:description],
    :latitude => params[:latitude],
    :longitude => params[:longitude]
  }
  w = Waypoint.create(a)
  w.save
  content_type :js
  w.to_json
end
