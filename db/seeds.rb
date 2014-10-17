# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

  seed_urls = [
      'http://apple.com',
      'https://apple.com',
      'https://www.apple.com',
      'http://developer.apple.com',
      'http://en.wikipedia.org',
      'http://opensource.org'
    ]

  seed_referrers = [
      'http://apple.com',
      'https://apple.com',
      'https://www.apple.com',
      'http://developer.apple.com',
      'NULL'
  ]

  seeds = Array.new

  for seed_index in 1..1000000 do
    value_str = "'#{seed_urls.sample}', '#{seed_referrers.sample}', DATE(NOW()-INTERVAL #{rand(0..9).to_s} DAY)"
    #seeds.push( value_str + ", md5(#{value_str})))" )
    seeds.push( value_str )

    # puts(seed_index)
  end

  selection_size = 1000
  
  selection_size.times do |n|
    sql = "INSERT INTO page_views (`url`, `referrer`, `created_at`) VALUES (#{seeds[n*selection_size,selection_size].join("), (")})"
    connection = ActiveRecord::Base.connection
    connection.execute(sql)
  end