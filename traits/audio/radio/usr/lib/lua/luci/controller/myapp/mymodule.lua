--[[
Install to
/usr/lib/lua/luci/controller/myapp/mymodule.lua
]]--

module("luci.controller.myapp.mymodule", package.seeall)

function index()

    entry({"admin", "radio", "stations"}, cbi("myapp-mymodule/radio"), "Radio stations", 30).dependent=false
    entry({"admin", "radio", "remote"}, cbi("myapp-mymodule/remote"), "Radio remote control", 30).dependent=false

--    entry({"click", "here", "now"}, call("action_tryme"), "Click here", 10).dependent=false
--    entry({"my", "new", "template"}, template("myapp-mymodule/helloworld"), "Hello world", 20).dependent=false

end

