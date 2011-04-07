require 'rubygems'
require 'sinatra'
require 'builder'
require 'sunlight'

set :sunlight_key, ENV['sunlight_key']

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
