class Racer
  include Mongoid::Document
  include ActiveModel::Model
 
  require 'mongo'
  require 'pp'
  require 'byebug'
  require 'uri'

  	attr_accessor :id, :number, :first_name, :last_name, :gender, :group, :secs

	@@db = nil

def self.mongo_client
    @@db = Mongo::Client.new('mongodb://localhost:27017/raceday_development')
  end

def save
	result = self.class.collection.insert_one(number:@number, first_name:@first_name, last_name:@last_name, gender:@gender, group:@group, secs:@secs)
	@id=result.inserted_id.to_s
end

def persisted?
    !@id.nil?
  end
  

def update(params)
	@number = params[:number].to_i
	@first_name = params[:first_name]
	@last_name = params[:last_name]
	@gender = params[:gender]
	@group = params[:group]
	@secs = params[:secs]

	params.slice!(:number, :first_name, :last_name, :gender, :group, :secs)
	self.class.collection.find(:_id => BSON::ObjectId.from_string(@id)).update_one(params)

end

def destroy
	self.class.collection.find(:_id => BSON::ObjectId.from_string(@id)).delete_one
end

def self.collection
    self.mongo_client if not @@db
    @@db[:racers]
end

def initialize(params={})
	@id=params[:_id].nil? ? params[:id] : params[:_id].to_s
	@number=params[:number].to_i
	@first_name=params[:first_name]
	@last_name=params[:last_name]
	@gender=params[:gender]
	@group=params[:group]
	@secs=params[:secs].to_i
end
def self.find id
	result=collection.find(:_id => BSON::ObjectId.from_string(id))
  					 .projection({_id:true, number:true, first_name:true, last_name:true, gender:true, group:true, secs:true})
  					 .first
  	return result.nil? ? nil : Racer.new(result)
end


def self.all(prototype={}, sort={}, skip=0, limit=nil)
	if !limit.nil?
	 	return @@db[:racers].find(prototype).sort(sort).skip(skip).limit(limit)
    end

    return @@db[:racers].find(prototype).sort(sort).skip(skip)
end

end
