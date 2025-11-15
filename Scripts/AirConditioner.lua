local AirConditioner = GameMain:NewMod("AirConditioner");--先注册一个新的MOD模块

function AirConditioner:OnInit()
--[[
  self.ShengHua = self.ShengHua or false;
  self.HuChi = self.HuChi or false;
  self.stored_list = self.stored_list or {};
  --]]
end

function AirConditioner:OnEnter()

end

--[[
function AirConditioner:OnSetHotKey()
  local tbHotKey = { {ID = "ShowSetting" , Name = "藏经阁设置" , Type = "Mod", InitialKey1 = "LeftShift+Q" } };
	return tbHotKey;
end

function AirConditioner:OnHotKey(ID,state)
  --[[
  if ID == "ShowSetting" and state == "down" then
    GameMain:GetMod("Windows"):GetWindow("SettingWindow"):Show();
  end
  -]]
end
--]]

function AirConditioner:OnStep(dt)--请谨慎处理step的逻辑，可能会影响游戏效率

end

function AirConditioner:OnLeave()

end

function AirConditioner:OnSave()--系统会将返回的table存档 table应该是纯粹的KV
--[[
  return {
    shenghua = self.ShengHua,
    huchi = self.HuChi,
    stored_list = self.stored_list,
  };
  --]]
end

function AirConditioner:OnLoad(tbData)--读档时会将存档的table回调到这里
  --[[
  tbData = tbData or {};
  self.ShengHua = tbData.shenghua or false;
  self.HuChi = tbData.huchi or false;
  self.stored_list = tbData.stored_list or {};
  --]]
end

--[[

--custom methods.
function AirConditioner:StoreList(id, eso_list)
  self.stored_list[id] = eso_list;
end

function AirConditioner:SpawnBook(id, key)
  eso_list = self.stored_list[id];
  if eso_list and key then
    for _,name in pairs(eso_list) do
      itemThing = ThingMgr:AddSysEsotericaItem(0, name, Map);
      Map:DropItem(itemThing, key, true, true, false, true);
    end
    self.stored_list[id] = nil;
  end
end
--]]