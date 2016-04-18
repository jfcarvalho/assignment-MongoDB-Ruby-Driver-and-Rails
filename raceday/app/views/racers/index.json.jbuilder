json.array!(@racers) do |racer|
  json.extract! racer, :id, :number, :first_name, :last_name, :gender, :group, :secs
  json.url racer_url(racer, format: :json)
end

json.array!(@racers) do |racer|
	racer=toRacer(racer)
	json.extract! racer, :id, :number, :first_name, :last_name, :gender, :group, :secs
	json.url racer_url(racer, format: :json)
end	
