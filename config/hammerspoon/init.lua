function toggleApp(app_name, key)
    hs.hotkey.bind({ "option" }, key, function()
        local app = hs.application.get(app_name)
        if app == nil then
            hs.application.launchOrFocus("/Applications/" .. app_name .. ".app")
        elseif app:isFrontmost() then
            app:hide()
        else
            local space = hs.spaces.focusedSpace()
            local win = app:focusedWindow()
            --hs.spaces.moveWindowToSpace(win, space)
            win:focus()
        end
    end)
end

toggleApp("kitty", "space")
toggleApp("Notion", "n")
toggleApp("Slack", "h")
toggleApp("Google Chrome", "j")
toggleApp("Visual Studio Code", "k")
toggleApp("Todoist", "l")
