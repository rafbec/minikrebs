--[[
Install to
/usr/lib/lua/luci/controller/myapp/mymodule.lua
]]--

module("luci.controller.myapp.mymodule", package.seeall)

function index()

--  Create a new item in the main menu bar
    entry({"admin", "radio"}, cbi("myapp-mymodule/radio"), _("Radio"), 21).dependent = true

--  Attach the submenus to the main menu item
    entry({"admin", "radio", "stations"}, cbi("myapp-mymodule/radio"), "Radio stations", 30).dependent=true
    entry({"admin", "radio", "remote"}, cbi("myapp-mymodule/remote"), "Radio remote control", 31).dependent=true

--    entry({"click", "here", "now"}, call("action_tryme"), "Click here", 10).dependent=false
--    entry({"my", "new", "template"}, template("myapp-mymodule/helloworld"), "Hello world", 20).dependent=false

end
