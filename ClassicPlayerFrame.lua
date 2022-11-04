-- LoadAddOn("Blizzard_DebugTools")

-- DevTools_Dump()
local PlayerName = PlayerName
local PlayerFrame = PlayerFrame
local PlayerLevelText = PlayerLevelText
local PlayerHitIndicator = PlayerHitIndicator
local PlayerFrameManaBar = PlayerFrameManaBar
local PlayerFrameHealthBar = PlayerFrameHealthBar

local function updateBarTexture(self, texture)	
	if (texture == "Interface\\TargetingFrame\\UI-StatusBar") then return end
	self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
end
local function updateBarColor(self, r, g, b, a)
	local color = {};
	color.r = 0;
	color.g = 1;
	color.b = 0;
	if (self.powerType) then
		color = GetPowerBarColor(self.powerType)
	end
	if (color.r ~= r or color.g ~= g or color.b ~= b) then
		self:SetStatusBarColor(color.r, color.g, color.b)
	end
end

PlayerFrame.PlayerFrameContainer.FrameTexture:ClearAllPoints()
PlayerFrame.PlayerFrameContainer.FrameTexture:SetPoint("TOPLEFT", PlayerFrame.PlayerFrameContainer, "TOPLEFT", -20, -5)
PlayerFrame.PlayerFrameContainer.FrameTexture:SetSize(232, 100)
PlayerFrame.PlayerFrameContainer.FrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
--<TexCoords left="1.0" right="0.09375" top="0" bottom="0.78125"/>
PlayerFrame.PlayerFrameContainer.FrameTexture:SetTexCoord(1, 0.09375, 0, 0.78125)
PlayerFrame.PlayerFrameContainer:SetFrameLevel(4)
PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:SetFrameLevel(5)
PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetSize(64, 64)

local function HookBars(frameToHook)
	updateBarTexture(frameToHook);
	updateBarColor(frameToHook);
	hooksecurefunc(frameToHook, "SetStatusBarTexture", updateBarTexture)
	hooksecurefunc(frameToHook, "SetStatusBarColor", updateBarColor)
end

HookBars(PlayerFrameHealthBar)
HookBars(PlayerFrameManaBar)

hooksecurefunc("PlayerFrame_UpdatePvPStatus", function()
	PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigeBadge)
	PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait)
	PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerPortraitCornerIcon)
 end)

 hooksecurefunc("PlayerFrame_ToPlayerArt", function()
	PlayerFrameHealthBar:SetSize(119, 8);
	PlayerFrameHealthBar:SetPoint("TOPLEFT", 88, -48);

	PlayerFrameManaBar:SetSize(119, 9);
	PlayerFrameManaBar:SetPoint("TOPLEFT", 88, -59);

	local manaBarMask = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarMask;
	manaBarMask:SetAtlas("")
	manaBarMask:SetWidth(121);
	manaBarMask:SetHeight(13);
	manaBarMask:SetPoint("TOPLEFT", manaBarMask:GetParent(), "TOPLEFT", 86, -56);
 end)

 hooksecurefunc("PlayerFrame_UpdateStatus", function()
	PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture);
 end)

 hooksecurefunc("PlayerFrame_UpdatePlayerNameTextAnchor", function()
	PlayerName:ClearAllPoints()
	PlayerName:SetJustifyH("CENTER")
	PlayerName:SetPoint("TOPLEFT", PlayerFrame.PlayerFrameContainer, "TOPLEFT", 97, -31)
 end)

 hooksecurefunc("PlayerFrame_UpdateLevel", function()
	PlayerLevelText:ClearAllPoints();
	PlayerLevelText:SetPoint("CENTER", PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual, "CENTER", -81, -22)
	PlayerLevelText:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)
	PlayerHitIndicator:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)
 end)

 hooksecurefunc("PlayerFrame_UpdateRolesAssigned", function()
	local roleIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.RoleIcon;
	roleIcon:SetShown(true);
	roleIcon:ClearAllPoints();
	roleIcon:SetPoint("CENTER", PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.LeaderIcon, "CENTER", 15, 0)

	PlayerLevelText:SetShown(true);
 end)

local function holyPower(self)
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", 10, 15)
end
local function alternatePower(self)
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", 30, 5)
end
hooksecurefunc("AlternatePowerBar_OnEvent", alternatePower)
PaladinPowerBarFrame:HookScript("OnEvent", holyPower)