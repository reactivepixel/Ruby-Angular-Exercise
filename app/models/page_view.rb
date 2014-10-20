class PageView < ActiveRecord::Base

	# Unable to get Sequel to fully interface with ActiveRecord

	config   = Rails.configuration.database_configuration
	host     = config[Rails.env]["host"]
	adapter  = config[Rails.env]["adapter"]
	database = config[Rails.env]["database"]
	username = config[Rails.env]["username"]
	password = config[Rails.env]["password"]
	rows = Array.new
	
	# Force a connection to the DB through Sequel for testing
	DB = Sequel.connect("#{adapter}://#{host}/?database=#{database}&username=#{username}&password=#{password}&database=#{database}")
	
	#  Select Top 5 URLs from the last 5 days
	5.times do |n|
		rows.push( DB[:page_views]
			.group_and_count(:created_at, :url)
			.where("created_at = DATE_SUB(CURRENT_DATE, INTERVAL #{n} DAY)")
			.order("count desc")
			.limit(5)
			.all
		)
	end

	puts rows
	
	# Testing output to Rails Console
	# pv = PageView.new
	
end