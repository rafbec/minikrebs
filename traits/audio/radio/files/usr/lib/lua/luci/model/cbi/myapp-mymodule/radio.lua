-- uci config file /etc/config/radio, for this to work 
-- there must be a uci file created with "touch /etc/config/radio"
m = Map("radio", "Personal Audio")

s = m:section(TypedSection, "playonce", "Play once")
s.template  = "cbi/tblsection"

s.addremove = true -- Allow the user to create and remove playonce instances

p = s:option(ListValue, "type", "Type")
p:value("mp3", "MP3")
p:value("song", "Song")
p.default = "mp3"

url = s:option(Value, "url", "URL", "The http:// address of the mp3")
function url:validate(value)
    return value:match("http://.*")
end
url:depends("type", "mp3")

so = s:option(Value, "title", "Song title", "The name of the song")
so:depends("type", "song")

s = m:section(TypedSection, "station", "Stations")
s.template  = "cbi/tblsection"
function s:filter(value)
   return value ~= "next" and value -- Don't touch variable "radio.next"
end 

s.addremove = true -- Allow the user to create and station instances

p = s:option(ListValue, "type", "Station type")
p:value("mp3", "MP3 stream")
p:value("pls", "M3U/PLS playlist")
p:value("rss", "Podcast Feed")
p.default = "mp3"

url = s:option(Value, "url", "Stream URL", "The http:// address of the stream")
function url:validate(value)
    return value:match("http://.*")
end

p = s:option(ListValue, "sidtype", "Station ID type")
p:value("jingle", "Jingle")
p:value("spoken", "Spoken")
p.default = "jingle"

sidurl = s:option(Value, "sidurl", "Station ID URL", "The http:// address of the station ID (jingle)")
sidurl:depends("sidtype", "jingle")
function sidurl:validate(value)                          
    return value:match("http://.*")  
end

p = s:option(ListValue, "lang", "Language")
p:value("de", "German")
p:value("en_US", "English (US)")
p.default = "de"
p:depends("sidtype", "spoken")

n = s:option(Value, "speakname", "Speakable station name", "This spoken as the station ID if no jingle is present")
n:depends("sidtype", "spoken")

luci.util.exec("/etc/init.d radio start")

return m -- Returns the map
