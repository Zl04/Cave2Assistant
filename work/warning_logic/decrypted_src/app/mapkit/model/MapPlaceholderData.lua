local MapPlaceholderData = class("MapPlaceholderData")

function MapPlaceholderData:ctor(typeName, associatedID, associatedCoord, reachable, nodeOfPath, endOfPath, destructible)
	self.typeName = typeName
	self.associatedID = associatedID
	self.associatedCoord = associatedCoord;
	self.reachable = reachable or false
	self.destructible = destructible or false
	self.nodeOfPath = nodeOfPath or false
	self.endOfPath = endOfPath or false
end

function MapPlaceholderData:getTypeName()
	return self.typeName
end

function MapPlaceholderData:getAssocialtedID()
	return self.associatedID
end

function MapPlaceholderData:isReachable()
	return self.reachable
end

function MapPlaceholderData:isDestructible()
	return self.destructible
end

function MapPlaceholderData:canBeNodeOfPath()
	return self.nodeOfPath
end

function MapPlaceholderData:canBeEndOfPath()
	return self.endOfPath
end

return MapPlaceholderData