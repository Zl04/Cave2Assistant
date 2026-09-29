--[[--
控制器PetReincarnationController，view已经注入,可以通过mvc.petReincarnationProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: siyu.lin
-- date	: 2023/03/17
-- desc	: 
------------------------------------------------------------------------------
local PetReincarnationController = class("PetReincarnationController", mvc.GameController)

-- mvc.events.PetReincarnation_Req_Pet_Reincarnation 处理函数
function PetReincarnationController:noticePetReincarnationReqPetReincarnation(notification)
	local id = notification.id
	local petId = notification.petId

	-- 发送进阶请求
	if id and petId then
		local config = {}
		config.id = id
		config.petId = petId 
		Net.NetPetSystem:petAdvanceRequest(config)
	end
end



-- mvc.events.PetReincarnation_Show_Detail_Layer 处理函数
function PetReincarnationController:noticePetReincarnationShowDetailLayer(notification, data)
	print("noticePetReincarnationShowDetailLayer:  ", notification)
	if self.petReincarnationView and not tolua.isnull(self.petReincarnationView) then
        self.petReincarnationView:showDetailLayer(data)
    end
end



-- mvc.events.PetReincarnation_Update_Pet_Layout 处理函数
function PetReincarnationController:noticePetReincarnationUpdatePetLayout(notification, data)
	print("noticePetReincarnationUpdatePetLayout:  ", notification)
	if self.petReincarnationView and not tolua.isnull(self.petReincarnationView) then
        self.petReincarnationView:reincarnationRespond(data)
    end
end



return PetReincarnationController
