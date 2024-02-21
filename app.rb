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