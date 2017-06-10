$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'public_primary_key'

require 'minitest/autorun'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)
