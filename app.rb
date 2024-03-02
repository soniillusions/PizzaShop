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
	# получаем список параметров и парсим (parse) разбираем	 их
	@orders_input = params[:orders]
	@items = parse_orders_line(@orders_input)

	# выводим сооюзение о том что корзина пуста
	if @items.length == 0
		return erb :cart_is_empty
	end

	# выводим список продуктов в корзине
	@items.each do |item|
		item[0] = @products.find(item[0])
	end

	erb :cart
end

post '/place_order' do
	@order = Order.new(params[:order])

	if @order.save
		erb :order_placed
	else
		@error = @order.errors.full_messages.first
		erb :cart
	end
end

get '/admin' do
	@orders = Order.order('created_at DESC')
	erb :orders
end

post '/orders/:id/delete' do
	order = Order.find(params[:id])
	order.destroy
	redirect '/orders'
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

def orders_input_to_hash(order)
	orders_hash = {
		'1' => 'Hawaiian',
		'2' => 'Pepperoni',
		'3' => 'Vegetarian'
	}

	string = ''

	order_arr =	parse_orders_line(order)

	order_arr.each do |product|
		string += orders_hash[product[0]] + ' - ' + product[1] + ', '
	end

	return string
end
