-- uci config file /etc/config/radio, for this to work 
-- there must be a uci file created with "touch /etc/config/radio"
m = Map("radio", "Radio")

s = m:section(TypedSection, "rcc", "Remote Control Codes")
s.template  = "cbi/tblsection"
function s:filter(value)
   return value ~= "next" and value -- Don't touch variable "radio.next"
end 

s.addremove = true -- Allow the user to create and remove stations

p = s:option(ListValue, "repeat", "Key type")
p:value("0", "Not repeatable")
p:value("1", "Repeatable (e.g., volume keys)")
p.default = "0"

n = s:option(Value, "command", "Command", "The command to be executed when this command is received")

luci.util.exec("/etc/init.d/radio start")

return m -- Returns the map
