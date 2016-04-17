class Racer
  include Mongoid::Document

  require 'mongo'
  require 'pp'
  require 'byebug'
  require 'uri'


	@@db = nil

def self.mongo_client
    @@db = Mongo::Client.new('mongodb://localhost:27017/raceday_development')
  end

def self.collection
    self.mongo_client if not @@db
    @@db[:racers]
  end

def self.all(prototype={}, sort={}, skip=0, limit=nil)
	if !limit.nil?
	 	return @@db[:racers].find(prototype).sort(sort).skip(skip).limit(limit)
    end
    
    return @@db[:racers].find(prototype).sort(sort).skip(skip)
end

end
