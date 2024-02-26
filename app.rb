#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "pizzashop.db"}

class Product < ActiveRecord::Base
end

class Order < ActiveRecord::Base
end

before do
	@products = Product.all
	@orders = Order.all
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

get '/cart' do
	erb :cart
end

post '/cart' do
	orders_input = params[:orders]
	@items = parse_orders_line(orders_input)

	@items.each do |item|
		item[0] = @products.find(item[0])
	end

	erb :cart
end

def parse_orders_line orders_input
	s1 = orders_input.split(',')

	arr =[]

	s1.each do |product|
		s2 = product.split('=')

		s3 = s2[0].split('_')

		id = s3[1]
		amount = s2[1]

		arr2 = [id, amount]
		arr << arr2
	end

	return arr
end
