--[[--
控制器ComebackPackageController，view已经注入,可以通过mvc.comebackPackageProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: linfeng.li
-- date	: 2022/05/26
-- desc	: 
------------------------------------------------------------------------------
local ComebackPackageController = class("ComebackPackageController", mvc.GameController)

function ComebackPackageController:onUpdatePackageView(iapDatas)
    if self.comebackPackageView then
        self.comebackPackageView:updatePackageView(iapDatas)
    end
end

function ComebackPackageController:getComebackPackageView()
    return self.comebackPackageView
end

function ComebackPackageController:closeSelectLayer()
    mvc.closePanel("ComebackPackage", "ComebackPackage")
end



return ComebackPackageController

