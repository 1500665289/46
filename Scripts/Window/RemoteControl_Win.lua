local SimpleWindow = GameMain:GetMod("Windows");--先注册一个新的MOD模块
local tbWindow = SimpleWindow:CreateWindow("RemoteControl");


function tbWindow:OnInit()
	self.window.contentPane = UIPackage.CreateObject("NewBuilding", "Frame1");--载入UI包里的窗口
	self.window.closeButton = self:GetChild("n3");
	

	local in_bnt = self:GetChild("in_btn");
	--bnt1.onClick:Add(self:OnClick);
	in_bnt.onClick:Add(
		function ()
			self:GetChild("n5").text =tostring(tonumber(self:GetChild("n5").text) + 1);
			self.caller:RemoteToValue(tonumber(self:GetChild("n5").text));
			--[[
			for k,v in pairs(self.caller) do
				print(k,v);
			end
			--]]
		end
	);

	local de_bnt = self:GetChild("de_btn");
	--bnt1.onClick:Add(self:OnClick);
	de_bnt.onClick:Add(
		function ()
			self:GetChild("n5").text =tostring(tonumber(self:GetChild("n5").text) - 1);
			self.caller:RemoteToValue(tonumber(self:GetChild("n5").text));
			--print(self.caller);
		end
	);

  self.window:Center();
end

function tbWindow:OnShowUpdate()

end

function tbWindow:OnShown()

end

function tbWindow:OnUpdate(dt)

end

function tbWindow:OnHide()

end

function tbWindow:SetUpData(caller)
  self.caller = caller;
end
