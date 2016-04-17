class Racer
  include Mongoid::Document

  require 'mongo'
require 'pp'
require 'byebug'
require 'uri'

class Racer
	@@db = nil

def self.mongo_client
    @@db = Mongo::Client.new('mongodb://localhost:27017/')
  	@@db.use('raceday_development');
  end

def self.collection
    self.mongo_client if not @@db
    @@db[:racers]
  end

end

end
