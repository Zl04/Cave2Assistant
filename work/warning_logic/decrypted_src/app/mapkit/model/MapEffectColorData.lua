local MapEffectColorData = class("MapEffectColorData")

function MapEffectColorData:ctor(color, opacity)
	color.a = 255
	self.color = color
	self.opacity = opacity
end

function MapEffectColorData:getColor()
	return self.color
end

function MapEffectColorData:getOpacity()
	return self.opacity
end

return MapEffectColorData


