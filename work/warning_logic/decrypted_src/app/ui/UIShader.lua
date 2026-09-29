--[[
    UI － 着色器的定义
]]

UI = UI or {}

-- 通用着色器
UI.COMPONENT_NORMAL_SHADER = {
    KEY = "ShaderPositionTextureColor_noMVP",
    VERT_SHADER = "",
    FRAG_SHADER = ""
}

-- 变灰着色器
UI.COMPONENT_GRAY_SHADER = {
    KEY = "ComponentTurnGrayShader",
    VERT_SHADER = "shaders/TextureTurnGray.vert",
    FRAG_SHADER = "shaders/TextureTurnGray.frag"
}

-- 地图格子着色器
UI.COMPONENT_MAP_GRID_SHADER = {
    KEY = "ComponentMapGridShader",
    VERT_SHADER = "shaders/MapGrid.vert",
    FRAG_SHADER = "shaders/MapGrid.frag"
}

-- 变红着色器
UI.COMPONENT_TEXTURE_RED_COLOR = {
    KEY = "ComponentPositionTextureRedColor",
    VERT_SHADER = "shaders/PositionTextureRedColor.vert",
    FRAG_SHADER = "shaders/PositionTextureRedColor.frag"
}


-- 变红着色器
UI.COMPONENT_TEXTURE_RED_COLOR2 = {
    KEY = "ComponentPositionTextureRedColor2",
    VERT_SHADER = "shaders/PositionTextureRedColor2.vert",
    FRAG_SHADER = "shaders/PositionTextureRedColor2.frag"
}

UI.COMPONENT_LIGHT = {
    KEY = "ComponentTextureLaser",
    VERT_SHADER = "shaders/TextureLaser.vert",
    FRAG_SHADER = "shaders/TextureLaser.frag"
}

-- 变紫色红着色器
UI.COMPONENT_PURPLE_SHADER = {
    KEY = "ComponentTexturePurpleColor",
    VERT_SHADER = "shaders/TexturePurpleColor.vert",
    FRAG_SHADER = "shaders/TexturePurpleColor.frag"
}