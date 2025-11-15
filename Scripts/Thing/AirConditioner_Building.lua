local tbThing = GameMain:GetMod("ThingHelper"):GetThing("AirConditioner_Building");
local g_emBuildingState = CS.XiaWorld.g_emBuildingState;

--fixed interfaces.
function tbThing:OnInit()
	if self.Time == nil then
		self.Time = 0;
	end
	
	self.setTemperature = 20;
	--self.error = 3;
	self.RefreshRate = 2;
end

function tbThing:OnFlag(flag)
  
end

function tbThing:OnGetSaveData()

end

function tbThing:OnLoadData(tbData)

end

function tbThing:OnStep(dt)
	local it = self.it;

	if it.BuildingState == g_emBuildingState.Working then
		self.Time = self.Time + dt;
		if (it.AtRoom ~=nil ) then
			--print(it," At Room");
			if (self.Time>=2) then
			
				local num = 0;
				local count = 0;

					for k,thing in pairs(it.AtRoom.m_lisThingsInRoom) do
					  if thing and thing.IsValid and thing.def.Name ~= "Building_AirConditioner" then
						if thing.def.Heat then
						  num = num + thing.def.Heat.RoomValue * 25 / it.AtRoom.m_lisThingsInRoom * thing.def.Heat.Failing * thing.def.Heat.Failing;
						elseif thing.def and thing.def.Heat then
						  num = num + thing.def.Heat.RoomValue * 25 * math.max(1, thing.Count) / 4 / it.AtRoom.m_lisGrids.Count * thing.def.Heat.Failing * thing.def.Heat.Failing;
						end
					  elseif thing.def.Name == "Building_AirConditioner" then
						count = count + 1;
					  end
					end
				--print(num);

				xlua.private_accessible(CS.XiaWorld.AreaRoom);
				--local m_fTemperatureWall = it.AtRoom.m_fTemperatureWall;
				local globleTemperature = Map:GetGlobleTemperature();
				local temperatureOffset = num + it.AtRoom.m_fTemperatureWall;
				local diff = self.setTemperature - globleTemperature - temperatureOffset;

				setTemperatureAdjust = diff * it.AtRoom.m_lisGrids.Count / 25 / count;
				--print(setTemperature);
				it.def.Heat.RoomValue = setTemperatureAdjust;
				--print("设定室温: "..self.setTemperature,"当前温度为: "..it.AtRoom.Temperature,"温差为： ",self.setTemperature - it.AtRoom.Temperature);
				
				self.Time = 0;
			end
			
		end

		return;
	end


end

function tbThing:OnAfterLoad(dt)

end

function tbThing:OnDeath()
end

function tbThing:OnPutDown()
	self.it:RemoveBtnData("设定", nil, "bind.luaclass:GetTable():CallRemoteControl()", "调节空调温度", nil);
	self.it:AddBtnData("设定", nil, "bind.luaclass:GetTable():CallRemoteControl()", "调节空调温度", nil);
end

function tbThing:OnPickUp()
  
end

function tbThing:CallRemoteControl()
	local window = GameMain:GetMod("Windows"):GetWindow("RemoteControl");
	window:Hide();
	window:SetUpData(self);
	window:Show();
end

function tbThing:RemoteToValue(value)
	self.setTemperature = value;
	print("当前设定温度为：",self.setTemperature);
end
