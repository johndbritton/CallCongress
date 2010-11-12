require 'rubygems'
require 'sinatra'
require 'builder'
require 'yaml'
require 'sunlight'

config = YAML::load(File.read('config.yml'))
config.each_pair do |name, value|
  set name.to_sym, value
end

post '/' do
  builder :welcome
end

post '/people' do
  if params[:FromZip] then
    Sunlight::Base.api_key = settings.sunlight_key
    @members_of_congress = Sunlight::Legislator.all_in_zipcode(params[:FromZip])
    builder :people
  else
    redirect '/nozip'
  end
end

post '/nozip' do
  builder :nozip
end

post '/dial' do
  if params[:FromZip] then
    Sunlight::Base.api_key = settings.sunlight_key
    members_of_congress = Sunlight::Legislator.all_in_zipcode(params[:FromZip])
    @member = members_of_congress[params[:Digits].to_i-1]
    builder :dial
  else
    redirect '/nozip'
  end
end
