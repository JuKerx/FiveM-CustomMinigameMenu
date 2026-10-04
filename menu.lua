local pool = MenuPool.New()
local animEnabled = true
local timerBarPool = TimerBarPool.New()
local Host = true

local MapName = "Vinewood Hills"

function CreateLobbyMenu()
	CreateThread(function()
	local Name = GetPlayerName(PlayerId())

	local lobbyMenu = MainView.New("Race - " .. MapName, "Lobby Created by " .. Name, "", "", "")
	local columns = {
		SettingsListColumn.New("SETTINGS", Colours.HUD_COLOUR_BLUE),
		PlayerListColumn.New("JOINED PLAYERS", Colours.HUD_COLOUR_BLUE),
		MissionDetailsPanel.New("DETAILS", Colours.HUD_COLOUR_BLUE),
	}
	lobbyMenu:SetupColumns(columns)

	local handle = RegisterPedheadshot(PlayerPedId())
	while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do Wait(0) end
	local txd = GetPedheadshotTxdString(handle)
	lobbyMenu:HeaderPicture(txd, txd)

	UnregisterPedheadshot(handle)
	pool:AddPauseMenu(lobbyMenu)
	lobbyMenu:CanPlayerCloseMenu(true)
	lobbyMenu:AnimationEnabled(false)
	
	if Host then
		local host = UIMenuListItem.New("Number of Laps", { "1", "2", "3" }, 2)
		local host1 = UIMenuListItem.New("Time of Day", { "Noon", "Evening", "Night", "Morning"}, 0)
		local host2 = UIMenuListItem.New("Weather", { "Clear", "Cloudy", "Rain", "Fog"}, 0)
		local host3 = UIMenuCheckboxItem.New("Freeze Time", true, 1)

		local confirmbutton = UIMenuItem.New("Confirm Settings", "", 11, 9, 1, 1)

		lobbyMenu.SettingsColumn:AddSettings(host)
		lobbyMenu.SettingsColumn:AddSettings(host1)
		lobbyMenu.SettingsColumn:AddSettings(host2)
		lobbyMenu.SettingsColumn:AddSettings(host3)
		lobbyMenu.SettingsColumn:AddSettings(confirmbutton)

		confirmbutton.OnItemSelect = function(menu, item)
			print("Game Starting")
			lobbyMenu.Visible(false)
			Wait(1000)
			RegisterNetEvent('StartGame')
		end
	else
		local player = UIMenuListItem.New("Radio", { "Off", "Radio Los Santos", "West Coast Classics" }, 0)
		local readybutton = UIMenuItem.New("Ready", "", 11, 9, 1, 1)
		lobbyMenu.SettingsColumn:AddSettings(player)
		lobbyMenu.SettingsColumn:AddSettings(readybutton)
	end

	local friend = FriendItem.New(Name, Colours.HUD_COLOUR_BLUE, true, 1, "HOST", "")
	local friend1 = FriendItem.New("Player 2", Colours.HUD_COLOUR_BLUE, true, 1, "JOINED", "")
	local friend2 = FriendItem.New("Player 3", Colours.HUD_COLOUR_BLUE, true, 1, "JOINED", "")

	if IsUsingKeyboard(0) then
		friend:SetLeftIcon(LobbyBadgeIcon.IS_PC_PLAYER, false)
	elseif not IsUsingKeyboard(0) then
		friend:SetLeftIcon(LobbyBadgeIcon.IS_CONSOLE_PLAYER, false)
	elseif NetworkIsPlayerTalking(PlayerId()) then
		friend:SetLeftIcon(LobbyBadgeIcon.ACTIVE_HEADSET, false)
	end

	friend1:SetLeftIcon(LobbyBadgeIcon.IS_PC_PLAYER, false)

	friend2:SetLeftIcon(LobbyBadgeIcon.IS_CONSOLE_PLAYER, false)

	local panel = PlayerStatsPanel.New(Name, Colours.HUD_COLOUR_BLUE)
	panel:Description("")
	panel:HasPlane(true)
	panel:HasHeli(true)
	panel:HasBoat(true)
	panel:HasVehicle(true)
	panel.RankInfo:RankLevel(1)
	panel.RankInfo:UpLabel("1.00 K/D Ratio")
	panel.RankInfo:MidLabel("Clean Player")
	panel.RankInfo:LowLabel("Kingpin")
	panel:AddStat(PlayerStatsPanelStatItem.New("Stamina", "Tri-Athlete", 150))
	panel:AddStat(PlayerStatsPanelStatItem.New("Shooting", "Dead-Eye", 150))
	panel:AddStat(PlayerStatsPanelStatItem.New("Strength", "Body Builder", 150))
	panel:AddStat(PlayerStatsPanelStatItem.New("Stealth", "Ninja", 150))
	panel:AddStat(PlayerStatsPanelStatItem.New("Driving", "Pro Racer", 150))
	panel:AddStat(PlayerStatsPanelStatItem.New("Flying", "Ace", 150))
	panel:AddStat(PlayerStatsPanelStatItem.New("Mental State", "Normal", 0))
	friend:AddPanel(panel)

	local panel1 = PlayerStatsPanel.New("Player 2", Colours.HUD_COLOUR_BLUE)
	panel1:Description("")
	panel1:HasPlane(true)
	panel1:HasHeli(true)
	panel1:HasBoat(true)
	panel1:HasVehicle(true)
	panel1.RankInfo:RankLevel(1)
	panel1.RankInfo:UpLabel("1.00 K/D Ratio")
	panel1.RankInfo:MidLabel("Clean Player")
	panel1.RankInfo:LowLabel("Kingpin")
	panel1:AddStat(PlayerStatsPanelStatItem.New("Stamina", "Tri-Athlete", 150))
	panel1:AddStat(PlayerStatsPanelStatItem.New("Shooting", "Dead-Eye", 150))
	panel1:AddStat(PlayerStatsPanelStatItem.New("Strength", "Body Builder", 150))
	panel1:AddStat(PlayerStatsPanelStatItem.New("Stealth", "Ninja", 150))
	panel1:AddStat(PlayerStatsPanelStatItem.New("Driving", "Pro Racer", 150))
	panel1:AddStat(PlayerStatsPanelStatItem.New("Flying", "Ace", 150))
	panel1:AddStat(PlayerStatsPanelStatItem.New("Mental State", "Normal", 0))
	friend1:AddPanel(panel1)

	local panel2 = PlayerStatsPanel.New("Player 3", Colours.HUD_COLOUR_BLUE)
	panel2:Description("")
	panel2:HasPlane(true)
	panel2:HasHeli(true)
	panel2:HasBoat(true)
	panel2:HasVehicle(true)
	panel2.RankInfo:RankLevel(1)
	panel2.RankInfo:UpLabel("1.00 K/D Ratio")
	panel2.RankInfo:MidLabel("Clean Player")
	panel2.RankInfo:LowLabel("Kingpin")
	panel2:AddStat(PlayerStatsPanelStatItem.New("Stamina", "Tri-Athlete", 150))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Shooting", "Dead-Eye", 150))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Strength", "Body Builder", 150))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Stealth", "Ninja", 150))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Driving", "Pro Racer", 150))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Flying", "Ace", 150))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Mental State", "Normal", 0))
	friend2:AddPanel(panel2)

	lobbyMenu.PlayersColumn:AddPlayer(friend)
	lobbyMenu.PlayersColumn:AddPlayer(friend1)
	lobbyMenu.PlayersColumn:AddPlayer(friend2)

	
	local txd = CreateRuntimeTxd("scaleformui");
	local _paneldui = CreateDui("https://i.imgur.com/mH0Y65C.gif", 288, 160)
	CreateRuntimeTextureFromDuiHandle(txd, "lobby_panelbackground", GetDuiHandle(_paneldui))

	lobbyMenu.MissionPanel:UpdatePanelPicture("scaleformui", "lobby_panelbackground")
	lobbyMenu.MissionPanel:Title(MapName)
	local detailItem1 = UIMenuFreemodeDetailsItem.New("Laps", "2", false)
	local detailItem2 = UIMenuFreemodeDetailsItem.New("Time", "Noon", false)
	local detailItem3 = UIMenuFreemodeDetailsItem.New("Weather", "Clear", false)
	local detailItem4 = UIMenuFreemodeDetailsItem.New("Freeze Time", "No", false)
	lobbyMenu.MissionPanel:AddItem(detailItem1)
	lobbyMenu.MissionPanel:AddItem(detailItem2)
	lobbyMenu.MissionPanel:AddItem(detailItem3)
	lobbyMenu.MissionPanel:AddItem(detailItem4)
	lobbyMenu.MissionPanel:AddItem(detailItem5)
	lobbyMenu.MissionPanel:AddItem(detailItem6)
	lobbyMenu.MissionPanel:AddItem(detailItem7)

	lobbyMenu.SettingsColumn.OnIndexChanged = function(idx)
		ScaleformUI.Notifications:ShowSubtitle("SettingsColumn index =>~b~ ".. idx .. "~w~.")
	end

	lobbyMenu.PlayersColumn.OnIndexChanged = function(idx)
		ScaleformUI.Notifications:ShowSubtitle("PlayersColumn index =>~b~ ".. idx .. "~w~.")
	end

	lobbyMenu:Visible(true)
end)
end

local MissionSelectorVisible = false
function CreateMissionSelectorMenu()

	MissionSelectorVisible = not MissionSelectorVisible

	if not MissionSelectorVisible then 
		ScaleformUI.Scaleforms.JobMissionSelector:Enabled(false) 
		return
	end

	local txd = CreateRuntimeTxd("test");
	local _paneldui = CreateDui("https://i.imgur.com/vlzezum.png", 288, 160);
	CreateRuntimeTextureFromDuiHandle(txd, "panelbackground", GetDuiHandle(_paneldui));

	ScaleformUI.Scaleforms.JobMissionSelector:SetTitle("Vote on the next Map")
	ScaleformUI.Scaleforms.JobMissionSelector.MaxVotes = 32
	ScaleformUI.Scaleforms.JobMissionSelector:SetVotes(votes, "Votes")
	ScaleformUI.Scaleforms.JobMissionSelector.Cards = {}

	local card = JobSelectionCard.New("Downtown LS", "Map", "test", "panelbackground", 0, 0, JobSelectionCardIcon.RACE, Colours.HUD_COLOUR_FREEMODE, 0, {
		MissionDetailsItem.New("Joined Players", "1", false),
		MissionDetailsItem.New("Time", "Noon", false),
		MissionDetailsItem.New("Weather", "Clear", false),
		MissionDetailsItem.New("Laps", "3", false),
		MissionDetailsItem.New("", "", false),
	})
	ScaleformUI.Scaleforms.JobMissionSelector:AddCard(card)

	local card1 = JobSelectionCard.New("Vinewood Hills", "Map", "test", "panelbackground", 0, 0, JobSelectionCardIcon.RACE, Colours.HUD_COLOUR_FREEMODE, 0, {
		MissionDetailsItem.New("Joined Players", "1", false),
		MissionDetailsItem.New("Time", "Noon", false),
		MissionDetailsItem.New("Weather", "Clear", false),
		MissionDetailsItem.New("Laps", "3", false),
		MissionDetailsItem.New("", "", false),
	})
	ScaleformUI.Scaleforms.JobMissionSelector:AddCard(card1)

	local card2 = JobSelectionCard.New("South LS", "Map", "test", "panelbackground", 0, 0, JobSelectionCardIcon.RACE, Colours.HUD_COLOUR_FREEMODE, 0, {
		MissionDetailsItem.New("Joined Players", "1", false),
		MissionDetailsItem.New("Time", "Noon", false),
		MissionDetailsItem.New("Weather", "Clear", false),
		MissionDetailsItem.New("Laps", "3", false),
		MissionDetailsItem.New("", "", false),
	})
	ScaleformUI.Scaleforms.JobMissionSelector:AddCard(card2)

	local card3 = JobSelectionCard.New("Vespucci Beach", "Map", "test", "panelbackground", 0, 0, JobSelectionCardIcon.RACE, Colours.HUD_COLOUR_FREEMODE, 0, {
		MissionDetailsItem.New("Joined Players", "1", false),
		MissionDetailsItem.New("Time", "Noon", false),
		MissionDetailsItem.New("Weather", "Clear", false),
		MissionDetailsItem.New("Laps", "3", false),
		MissionDetailsItem.New("", "", false),
	})
	ScaleformUI.Scaleforms.JobMissionSelector:AddCard(card3)

	local card4 = JobSelectionCard.New("Grapeseed", "Map", "test", "panelbackground", 0, 0, JobSelectionCardIcon.RACE, Colours.HUD_COLOUR_FREEMODE, 0, {
		MissionDetailsItem.New("Joined Players", "1", false),
		MissionDetailsItem.New("Time", "Noon", false),
		MissionDetailsItem.New("Weather", "Clear", false),
		MissionDetailsItem.New("Laps", "3", false),
		MissionDetailsItem.New("", "", false),
	})
	ScaleformUI.Scaleforms.JobMissionSelector:AddCard(card4)

	local card5 = JobSelectionCard.New("Sandy Shores", "Map", "test", "panelbackground", 0, 0, JobSelectionCardIcon.RACE, Colours.HUD_COLOUR_FREEMODE, 0, {
		MissionDetailsItem.New("Joined Players", "1", false),
		MissionDetailsItem.New("Time", "Noon", false),
		MissionDetailsItem.New("Weather", "Clear", false),
		MissionDetailsItem.New("Laps", "3", false),
		MissionDetailsItem.New("", "", false),
	})
	ScaleformUI.Scaleforms.JobMissionSelector:AddCard(card5)

	ScaleformUI.Scaleforms.JobMissionSelector.Buttons = {
		JobSelectionButton.New("Discord", "Join the server's discord.", {
			MissionDetailsItem.New("Joined Players", "1", false),
			MissionDetailsItem.New("", "", false),
			MissionDetailsItem.New("", "", false),
			MissionDetailsItem.New("", "", false),
			MissionDetailsItem.New("", "", false),
		}),
		JobSelectionButton.New("Refresh", "description test", {
			MissionDetailsItem.New("Joined Players", "1", false),
			MissionDetailsItem.New("", "", false),
			MissionDetailsItem.New("", "", false),
			MissionDetailsItem.New("", "", false),
			MissionDetailsItem.New("", "", false),
		}),
		JobSelectionButton.New("Leave", "Return to Freeroam.", {
			MissionDetailsItem.New("Joined Players", "1", false),
			MissionDetailsItem.New("", "", false),
			MissionDetailsItem.New("", "", false),
			MissionDetailsItem.New("", "", false),
			MissionDetailsItem.New("", "", false),
		}),
	}
	ScaleformUI.Scaleforms.JobMissionSelector.Buttons[1].Selectable = false
	ScaleformUI.Scaleforms.JobMissionSelector.Buttons[2].Selectable = false
	ScaleformUI.Scaleforms.JobMissionSelector.Buttons[3].Selectable = false

	ScaleformUI.Scaleforms.JobMissionSelector.Buttons[3].OnButtonPressed = function()
		ScaleformUI.ScaleformUI.Scaleforms.JobMissionSelector:Enabled(false)
	end
	ScaleformUI.Scaleforms.JobMissionSelector:Enabled(true)
	
	Citizen.Wait(1000)
	ScaleformUI.Scaleforms.JobMissionSelector:ShowPlayerVote(0, GetPlayerName(PlayerId()), Colours.HUD_COLOUR_FREEMODE, true, true)
end
