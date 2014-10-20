require 'digest'
# Min url list provided
seed_urls = [
	'http://apple.com',
	'https://apple.com',
	'https://www.apple.com',
	'http://developer.apple.com',
	'http://en.wikipedia.org',
	'http://opensource.org',
	'http://football.fantasysports.yahoo.com/',
	'https://github.com'
]

# Min Referrers list provided
seed_referrers = [
	'http://apple.com',
	'https://apple.com',
	'https://www.apple.com',
	'http://developer.apple.com',
	'NULL',
	'https://github.com',
	'https://dribbble.com/highlights/',
	'https://dribbble.com/',
	'http://www.reddit.com/r/webdev',
	'https://www.facebook.com/',
	'http://techcrunch.com/',
	'http://recode.net/',
	'http://www.amazon.com/',
	'http://getbootstrap.com/'
]


seeds = Array.new
current_time = Time.now()


records_to_insert = 1000000
selection_size = 10000

# For so many records avoid using ActiveRecord for model generation, assemble sql manually by creating an array of all values to be inserted
records_to_insert.times do |n|
	
	# make randon selections from the supplied arrays
	url = seed_urls.sample
	referrer = seed_referrers.sample
	
	# select a random day between now and 31 days ago.
	offset = current_time - 86400 * rand(0..31)
	created_at = offset.strftime('%Y-%m-%d')

	# Assemble the string for each value
	value_str = "'#{n+1}', '#{url}', '#{referrer}', '#{created_at}', '#{Digest::MD5.hexdigest({id: n+1, url: url, referrer: referrer, created_at: created_at}.to_s)}'" 
	seeds.push( value_str )
end

# Take a subsection of seeds and insert them into the db
100.times do |n|
	sql = "INSERT INTO page_views (`id`,`url`, `referrer`, `created_at`, `hash`) VALUES (#{seeds[n*selection_size,selection_size].join("), (")})"

	# Create selection_size number of db connections.
	connection = ActiveRecord::Base.connection
	connection.execute(sql)
end