#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "pizzashop.db"}

class Product < ActiveRecord::Base
end

before do
	@products = Product.all
end

def cart_display_value(index)
	key = "product_#{index}"
	value = (params[key] || '0').to_i
	value
end

get '/' do
	@products = Product.all
	erb :index
end

get '/about' do
	erb :about
end

get '/contacts' do
	erb :contacts
end

post '/cart' do
	erb :cart
end