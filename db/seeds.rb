# Author: Chris Chapman chapman@apextion.com 
# 
	require 'digest'
	# Min url list provided
	seed_urls = [
		'http://apple.com',
		'https://apple.com',
		'https://www.apple.com',
		'http://developer.apple.com',
		'http://en.wikipedia.org',
		'http://opensource.org'
	]

	# Min Referrers list provided
	seed_referrers = [
		'http://apple.com',
		'https://apple.com',
		'https://www.apple.com',
		'http://developer.apple.com',
		'NULL'
	]


	seeds = Array.new
	current_time = Time.now()


	# For so many records avoid using ActiveRecord for model generation, assemble sql manually by creating an array of all values to be inserted
	1000000.times do |n|
		
		# make randon selections from the supplied arrays
		url = seed_urls.sample
		referrer = seed_referrers.sample
		
		# select a random day between now and 31 days ago.
		offset = current_time - 86400 * rand(0..31)
		created_at = offset.strftime('%Y-%m-%d')
		value_str = "'#{n+1}', '#{url}', '#{referrer}', '#{created_at}', '#{Digest::MD5.hexdigest({id: n+1, url: url, referrer: referrer, created_at: created_at}.to_s)}'" 

		seeds.push( value_str )
		puts("Writing value #{n}.")
	end

	puts("--Splitting and Inserting to DB--")

	# Take a subsection of seeds and insert them into the db
	1000.times do |n|
		sql = "INSERT INTO page_views (`id`,`url`, `referrer`, `created_at`, `hash`) VALUES (#{seeds[n*1000,1000].join("), (")})"
		#sql = "INSERT INTO page_views (`id`,`url`, `referrer`, `created_at`, `hash`) VALUES (#{seeds.join("), (")})"

		# Create selection_size number of db connections. todo: Find a more elegant solution than 1000 db connections
		connection = ActiveRecord::Base.connection
		connection.execute(sql)
	end