class PageView < ActiveRecord::Base

	require "rubygems"
	require "mysql2"
	require "sequel"

	config   = Rails.configuration.database_configuration
	host     = config[Rails.env]["host"]
	adapter  = config[Rails.env]["adapter"]
	database = config[Rails.env]["database"]
	username = config[Rails.env]["username"]
	password = config[Rails.env]["password"]

	
	DB = Sequel.connect("#{adapter}://#{host}/?database=#{database}&username=#{username}&password=#{password}&database=#{database}")
	

	current_time = Time.now()
	range = current_time - 86400 * rand(0..5)

	page_views = DB[:page_views].group_and_count(:created_at, :url).where("created_at >= DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY)").all

	puts page_views


end


# pv = PageView.new