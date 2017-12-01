
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
    return '?? ����� ���� ����� ??????\n? '..plugin_name..' ' 
  end 
  if plugin_exists(plugin_name) then 
    table.insert(_config.enabled_plugins, plugin_name) 
    print(plugin_name..' added to _config table') 
    save_config() 
    reload_plugins( )
    return '?? �� ����� ����� ??????\n? '..plugin_name..' ' 
  else 
    return '?? �� ���� ��� ���� ����� ??\n? '..plugin_name..''
  end 
  
end 

local function disable_plugin( name, chat ) 
  if not plugin_exists(name) then 
    return '?? �� ���� ��� ���� ����� ?? \n\n'
  end 
  local k = plugin_enabled(name) 
  if not k then 
    return '?? ����� ���� ����� ??\n? '..name..' ' 
  end 
  table.remove(_config.enabled_plugins, k) 
  save_config( ) 
  reload_plugins( ) 
  return '?? �� ����� ����� ??\n? '..name..' ' 
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
       return '??��� ���� ���� ���� ���� ����� ������ �������� ??' 
    end 
    print("disable: "..matches[2]) 
    return disable_plugin(matches[2]) 
  end 
  if (matches[1] == '�����'  or matches[1]=="we") and is_sudo(msg) then --after changed to moderator mode, set only sudo 
  plugins = {} 
  load_plugins() 
  return "??�� ����� �������?????? ??"
  end 
  ----------------
   if (matches[1] == "sp" or matches[1] == "��� ���") and is_sudo(msg) then 
     if (matches[2]=="����" or matches[2]=="all") then
   tdcli.sendMessage(msg.to.id, msg.id, 1, '����� ����� ��� ��� ������ �� �������??', 1, 'html')

  for k, v in pairs( plugins_names( )) do  
      -- get the name 
      v = string.match (v, "(.*)%.lua") 
      		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..v..".lua", '?? ����� ���� �� ����  ��������� ?? \n?? ���� ���� ������ @lBOSSl\n????�??', dl_cb, nil)

  end 
else
local file = matches[2] 
  if not plugin_exists(file) then 
    return '?? �� ���� ��� ���� ����� .\n\n'
  else 
tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..file..".lua", '?? ����� ���� �� ����  ��������� ?? \n?? ���� ���� ������ @lBOSSl\n????�??', dl_cb, nil)
end
end
end

if (matches[1] == "dp" or matches[1] == "��� ���")  and matches[2] and is_sudo(msg) then 

    disable_plugin(matches[2]) 
    if disable_plugin(matches[2]) == '?? �� ���� ��� ���� �����?? \n\n' then
      return '?? �� ���� ��� ���� ����� ?? \n\n'
      else
        text = io.popen("rm -rf  plugins/".. matches[2]..".lua"):read('*all') 
  return '�� ��� ����� \n? '..matches[2]..'\n �� '..(msg.from.first_name or "erorr")..'\n'
 end
end 

if matches[1]:lower() == "ssp" and matches[2] and matches[3] then

local send_file = "./"..matches[2].."/"..matches[3]
tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, send_file, '?? ����� ���� �� ����  ��������� ?? \n?? ���� ���� ������ @lBOSSl\n????�??', dl_cb, nil)
end

if (matches[1] == '��� ������ ����������' or matches[1] == 'up') and is_sudo(msg) then
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "��� ������� ������ ������� ��� ??" end

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
tdcli.sendMessage(msg.to.id, msg.id_,1, '�� ��� ��� ������ ���������� \n������� ��������� ���  ������ ��� ��������� ������� �����', 1, 'html')
    else
        tdcli.sendMessage(msg.to.id, msg.id_, 1, '_���� ��� ���� ����� _', 1, 'md')
    end
else
    tdcli.sendMessage(msg.to.id, msg.id_, 1, '_��� ����� ��� ����� .json _', 1, 'md')
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

if (matches[1] == '��� �����' or matches[1] == 'save') and matches[2] and is_sudo(msg) then
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
tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>����� </b> <code>'..matches[2]..'.lua</code> <b> �� ���� �� ������</b>', 1, 'html')
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_����� ��� ����� lua._', 1, 'md')
end
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_����� ���� ���� ����� �����._', 1, 'md')
end
end

end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
end
   
end
if (matches[1] == '���� ��������' or matches[1] == 'bu') and is_sudo(msg) then
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "��� ������� ������ ������� ��� ??" end

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


tdcli.sendDocument(msg.from.id,0,0, 1, nil, "./data/moderation.json", '?? ����� ���� �� ����  ��������� ?? \n?? ����� ����� ��� '..i..' ������� ������\n?? ���� ���� ������ @lBOSSl\n????�??', dl_cb, nil)
if msg.to.type ~= 'pv' then
tdcli.sendMessage(msg.to.id, msg.id_, 1, '�� ������ ��� ���� ���������� �������� �� �����', 1, 'md')
end

end

if (matches[1] == 'source' or matches[1] == '������') and is_sudo(msg) then
return "?? ����� ������ : "..moody
end 

if (matches[1] == '����� ������' or matches[1] == 'update') and is_sudo(msg) then
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "��� ������� ������ ������� ��� ??" end

tdcli.sendMessage(msg.to.id, msg.id_,1, '?? ���� ����� ������ ...', 1, 'html')

download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/banhammer.lua','./plugins/banhammer.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/groupmanager.lua','./plugins/groupmanager.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/msg_checks.lua','./plugins/msg_checks.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/plugins.lua','./plugins/plugins.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/replay.lua','./plugins/replay.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/tools.lua','./plugins/tools.lua')
download_to_file('https://raw.githubusercontent.com/moody2020/TH3BOSS/master/plugins/zhrf.lua','./plugins/zhrf.lua')

  plugins = {} 
  load_plugins() 
  
tdcli.sendMessage(msg.to.id, msg.id_,1, '?? �� ������� ������ \n ���� �� ������ "������" ������ ����� ������.', 1, 'html')

end


end 

return { 
  patterns = { 
    "^/p$", 
    "^/p? (+) ([%w_%.%-]+)$", 
    "^/p? (-) ([%w_%.%-]+)$", 
    "^(sp) (.*)$", 
	"^(dp) (.*)$", 
	"^(��� ���) (.*)$",
  	"^(��� ���) (.*)$",
    "^(�����)$",
    "^(we)$",
    "^(���� ��������)$",
    "^(bu)$",
    "^(up)$",
    "^(��� ���� ��������)$",
    "^(ssp) ([%w_%.%-]+)/([%w_%.%-]+)$",
	"^(����� ������)$",
	"^(update)$",
	"^(������)$",
	"^(surce)$",
    "^(��� �����) (.*)$",
	"^(save) (.*)$",
 }, 
  run = moody, 
  moderated = true, 
  --privileged = true 
} 

end