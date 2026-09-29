require "utils.userdata.UserData"

Avalon = Avalon or {}

local PurchaseData = class("PurchaseData", Avalon.UserData)
Avalon.PurchaseData = PurchaseData

function PurchaseData:ctor()
    PurchaseData.super.ctor(self, USER_DATA_TYPE.PURCHASE)
    self.orders = {}
    self.products = {}
end

function PurchaseData:getAllOrders()
    return self.orders
end

function PurchaseData:getProducts()
    return self.products
end