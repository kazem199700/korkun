
do 

moody = '23'

local function plugin_enabled( name ) 
  for k,v in pairs(_config.enabled_plugins) do 
    if name == v then 
      return k 
    end 
  end 
  return false 
end 


local function plugin_exists( name ) 
  for k,v in pairs(plugins_names()) do 
    if name..'.lua' == v then 
      return true 
    end 
  end 
  return false 
end 

local function list_all_plugins(only_enabled)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ?? enabled, ? disabled
    local status = '?' 
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '??' 
      end
      nact = nact+1
    end
    if not only_enabled or status == '*|??|>*'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'-'..status..'? '..check_markdown(v)..' \n'
    end
  end
  return text
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end 

local function enable_plugin( plugin_name ) 
  print('checking if '..plugin_name..' exists') 
  if plugin_enabled(plugin_name) then 
    return '?? Çáãáİ ãİÚá ÓÇÈŞÇ ??????\n? '..plugin_name..' ' 
  end 
  if plugin_exists(plugin_name) then 
    table.insert(_config.enabled_plugins, plugin_name) 
    print(plugin_name..' added to _config table') 
    save_config() 
    reload_plugins( )
    return '?? Êã ÊİÚíá Çáãáİ ??????\n? '..plugin_name..' ' 
  else 
    return '?? áÇ íæÌÏ ãáİ ÈåĞÇ ÇáÇÓã ??\n? '..plugin_name..''
  end 
  
end 

local function disable_plugin( name, chat ) 
  if not plugin_exists(name) then 
    return '?? áÇ íæÌÏ ãáİ ÈåĞÇ ÇáÇÓã ?? \n\n'
  end 
  local k = plugin_enabled(name) 
  if not k then 
    return '?? Çáãáİ ãÚØá ÓÇÈŞÇ ??\n? '..name..' ' 
  end 
  table.remove(_config.enabled_plugins, k) 
  save_config( ) 
  reload_plugins( ) 
  return '?? Êã ÊÚØíá Çáãáİ ??\n? '..name..' ' 
end 


local function moody(msg, matches) 
  if matches[1] == '/p' and is_sudo(msg) then --after changed to moderator mode, set only sudo 
  
    return list_all_plugins() 
  end 
  if matches[1] == '+' and is_sudo(msg) then --after changed to moderator mode, set only sudo 
  
    local plugin_name = matches[2] 
    print("enable: "..matches[2]) 
    return enable_plugin(plugin_name) 
  end 
  if matches[1] == '-' and is_sudo(msg) then --after changed to moderator mode, set only sudo 
  
    if matches[2] == 'plugins'  then 
       return '??ÚæÏ ÇäÊå áæÊí ÊÑíÏ ÊÚØá ÇæÇãÑ ÇáÊÍßã ÈÇáãáİÇÊ ??' 
    end 
    print("disable: "..matches[2]) 
    return disable_plugin(matches[2]) 
  end 
  if (matches[1] == 'ÊÍÏíË'  or matches[1]=="we") and is_sudo(msg) then --after changed to moderator mode, set only sudo 
  plugins = {} 
  load_plugins() 
  return "??Êã ÊÍÏíË ÇáãáİÇÊ?????? ??"
  end 
  ----------------
   if (matches[1] == "sp" or matches[1] == "ÌáÈ ãáİ") and is_sudo(msg) then 
     if (matches[2]=="Çáßá" or matches[2]=="all") then
   tdcli.sendMessage(msg.to.id, msg.id, 1, 'ÇäÊÖÑ ŞáíáÇ Óæİ íÊã ÇÑÓÇáß ßá ÇáãáİÇÊ??', 1, 'html')

  for k, v in pairs( plugins_names( )) do  
      -- get the name 
      v = string.match (v, "(.*)%.lua") 
      		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..v..".lua", '?? Çáãáİ ãŞÏã ãä ŞäÇå  ÇáÜÒÚÜíÜã ?? \n?? ÊÇÈÚ ŞäÇå ÇáÓæÑÓ @lBOSSl\n??????', dl_cb, nil)

  end 
else
local file = matches[2] 
  if not plugin_exists(file) then 
    return '?? áÇ íæÌÏ ãáİ ÈåĞÇ ÇáÇÓã .\n\n'
  else 
tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..file..".lua", '?? Çáãáİ ãŞÏã ãä ŞäÇå  ÇáÜÒÚÜíÜã ?? \n?? ÊÇÈÚ ŞäÇå ÇáÓæÑÓ @lBOSSl\n??????', dl_cb, nil)
end
end
end

if (matches[1] == "dp" or matches[1] == "ÍĞİ ãáİ")  and matches[2] and is_sudo(msg) then 

    disable_plugin(matches[2]) 
    if disable_plugin(matches[2]) == '?? áÇ íæÌÏ ãáİ ÈåĞÇ ÇáÇÓã?? \n\n' then
      return '?? áÇ íæÌÏ ãáİ ÈåĞÇ ÇáÇÓã ?? \n\n'
      else
        text = io.popen("rm -rf  plugins/".. matches[2]..".lua"):read('*all') 
  return 'Êã ÍĞİ Çáãáİ \n? '..matches[2]..'\n íÇ '..(msg.from.first_name or "erorr")..'\n'
 end
end 

if matches[1]:lower() == "ssp" and matches[2] and matches[3] then

local send_file = "./"..matches[2].."/"..matches[3]
tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, send_file, '?? Çáãáİ ãŞÏã ãä ŞäÇå  ÇáÜÒÚÜíÜã ?? \n?? ÊÇÈÚ ŞäÇå ÇáÓæÑÓ @lBOSSl\n??????', dl_cb, nil)
end

if (matches[1] == 'ÑİÚ ÇáäÓÎå ÇáÇÍÊíÇØíå' or matches[1] == 'up') and is_sudo(msg) then
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ ??" end

if tonumber(msg.reply_to_message_id_) ~= 0  then
function get_filemsg(arg, data)
function get_fileinfo(arg,data)
if data.content_.ID == 'MessageDocument' then
fileid = data.content_.document_.document_.id_
filename = data.content_.document_.file_name_
if (filename:lower():match('.json$')) then
    local pathf = tcpath..'/data/document'..filename
    if pl_exiz(filename) then
        local pfile = 'data/moderation.json'
        os.rename(pathf, pfile)
        tdcli.downloadFile(fileid , dl_cb, nil)
tdcli.sendMessage(msg.to.id, msg.id_,1, 'Êã ÑİÚ ãáİ ÇáäÓÎå ÇáÇÍÊíÇØíå \nááÊÇßíÏ ÇáãÌãæÚÇÊ ßÊÈ  áÇÖåÇÑ ÚÏÏ ÇáãÌãæÚÇÊ ÇáãİÚáå ÓÇÈŞÇ', 1, 'html')
    else
        tdcli.sendMessage(msg.to.id, msg.id_, 1, '_åäÇß ÎØÇ ÍÇæá áÇÍŞÇ _', 1, 'md')
    end
else
    tdcli.sendMessage(msg.to.id, msg.id_, 1, '_åĞÇ Çáãáİ áíÓ ÈÕíÛå .json _', 1, 'md')
end
else
return
end
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
end

end

if (matches[1] == 'ÍİÙ Çáãáİ' or matches[1] == 'save') and matches[2] and is_sudo(msg) then
if tonumber(msg.reply_to_message_id_) ~= 0  then
function get_filemsg(arg, data)
function get_fileinfo(arg,data)

if data.content_.ID == 'MessageDocument' then
local doc_id = data.content_.document_.document_.id_
local filename = data.content_.document_.file_name_
local pathf = tcpath..'/data/document/'..filename
local cpath = tcpath..'/data/document'
if file_exi(filename, cpath) then
local pfile = "./plugins/"..matches[2]..".lua"
file_dl(doc_id)
if (filename:lower():match('.lua$')) then
os.rename(pathf, pfile)
tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Çáãáİ </b> <code>'..matches[2]..'.lua</code> <b> Êã ÑİÚå İí ÇáÓæÑÓ</b>', 1, 'html')
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Çáãáİ áíÓ ÈÕíÛå lua._', 1, 'md')
end
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Çáãáİ ÊÇáİ ÇÑÓá Çáãáİ ãÌÏÏÇ._', 1, 'md')
end
end

end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
end
   
end
if (matches[1] == 'äÓÎå ÇÍÊíÇØíå' or matches[1] == 'bu') and is_sudo(msg) then
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ ??" end

i = 1
local data = load_data(_config.moderation.data)
local groups = 'groups'
for k,v in pairsByKeys(data[tostring(groups)]) do
if data[tostring(v)] then
settings = data[tostring(v)]['settings']
end
for m,n in pairsByKeys(settings) do
if m == 'set_name' then
i = i + 1
end
end
end


tdcli.sendDocument(msg.from.id,0,0, 1, nil, "./data/moderation.json", '?? Çáãáİ ãŞÏã ãä ŞäÇå  ÇáÜÒÚÜíÜã ?? \n?? íÍÊæí Çáãáİ Úáì '..i..' ãÌãæÚÇÊ ãİÚáåå\n?? ÊÇÈÚ ŞäÇå ÇáÓæÑÓ @lBOSSl\n??????', dl_cb, nil)
if msg.to.type ~= 'pv' then
tdcli.sendMessage(msg.to.id, msg.id_, 1, 'Êã ÇÑÓÇáß ãáİ äÓÎå ÇáÇÍÊíÇØíå ááßÑæÈÇÊ İí ÇáÎÇÕ', 1, 'md')
end

end

if (matches[1] == 'source' or matches[1] == 'ÇáÓæÑÓ') and is_sudo(msg) then
return "?? ÇÕÏÇÑ ÇáÓæÑÓ : "..moody
end 

if (matches[1] == 'ÊÍÏíË ÇáÓæÑÓ' or matches[1] == 'update') and is_sudo(msg) then
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ ??" end

tdcli.sendMessage(msg.to.id, msg.id_,1, '?? ÌÇÑí ÊÍÏíË ÇáÓæÑÓ ...', 1, 'html')

download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/banhammer.lua','./plugins/banhammer.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/groupmanager.lua','./plugins/groupmanager.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/msg_checks.lua','./plugins/msg_checks.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/plugins.lua','./plugins/plugins.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/replay.lua','./plugins/replay.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/tools.lua','./plugins/tools.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/zhrf.lua','./plugins/zhrf.lua')

  plugins = {} 
  load_plugins() 
  
tdcli.sendMessage(msg.to.id, msg.id_,1, '?? Êã ÇáÊÍÏíË ÇáÓæÑÓ \n ÇáÇä Şã ÈÇÑÓÇá "ÇáÓæÑÓ" áãÚÑİå ÇÕÏÇÑ ÇáÓæÑÓ.', 1, 'html')

end


end 

return { 
  patterns = { 
    "^/p$", 
    "^/p? (+) ([%w_%.%-]+)$", 
    "^/p? (-) ([%w_%.%-]+)$", 
    "^(sp) (.*)$", 
	"^(dp) (.*)$", 
	"^(ÍĞİ ãáİ) (.*)$",
  	"^(ÌáÈ ãáİ) (.*)$",
    "^(ÊÍÏíË)$",
    "^(we)$",
    "^(äÓÎå ÇÍÊíÇØíå)$",
    "^(bu)$",
    "^(up)$",
    "^(ÑİÚ äÓÎå ÇÍÊíÇØíå)$",
    "^(ssp) ([%w_%.%-]+)/([%w_%.%-]+)$",
	"^(ÊÍÏíË ÇáÓæÑÓ)$",
	"^(update)$",
	"^(ÇáÓæÑÓ)$",
	"^(surce)$",
    "^(ÍİÙ Çáãáİ) (.*)$",
	"^(save) (.*)$",
 }, 
  run = moody, 
  moderated = true, 
  --privileged = true 
} 

end