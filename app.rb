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
	@user_name = params[:name]
	@user_phone = params[:phone]
	@user_address = params[:address]
	@user_order = params[:order_data]

	order = Order.new(name: @user_name, phone: @user_phone, address: @user_address, order_data: @user_order)

	if order.save
		puts 'Your order is in process.'
	else
		puts 'Failed to save order.'
	end

	redirect '/cart'
end

