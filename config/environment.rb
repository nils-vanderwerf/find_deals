# frozen_string_literal: true
require "require_all"
require "sqlite3"
# require_relative "../lib/version"

require 'bundler/setup'
Bundler.require

require "nokogiri"
require "open-uri"
require "rake"
require "pry"
require 'active_record'
require 'sinatra/activerecord'
require 'bundler/setup'

require_all "lib" #load up all files in the lib directory and its subdirectories

# connection to sqlite database here. creates the deals.sqlite database when running migrate
# We havew active record installed  
connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(:development)







