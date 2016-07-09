class TidelineSerializer < ActiveModel::Serializer
	attributes :id, :name, :lat, :lon, :wave_length, :swell_direction, :tide, :wind
end
