-- ~/.config/hypr/switch.lua
local previousWorkspaceID = nil
local currentWorkspaceID = hl.get_active_workspace().id

hl.on("hyprland.workspace_changed", function(ws)
	previousWorkspaceID = currentWorkspaceID
	currentWorkspaceID = ws.id
end)

hl.on("hyprland.window_closed", function()
	if previousWorkspaceID and previousWorkspaceID > 0 then
		hl.dispatch(hl.dsp.focus({ workspace = previousWorkspaceID }))
	end
end)
