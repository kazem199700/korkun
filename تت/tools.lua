--Begin Tools.lua :)

function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

 function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
local function index_function(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end
local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 
local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v[1] then
      return k
    end
  end
  -- If not found
  return false
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

 function exi_file()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.lua$')) then
            table.insert(files, v)
        end
    end
    return files
end

 function pl_exi(name)
    for k,v in pairs(exi_file()) do
        if name == v then
            return true
        end
    end
    return false
end
 function exi_filez()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.json$')) then
            table.insert(files, v)
        end
    end
    return files
end

 function pl_exiz(name)
    for k,v in pairs(exi_filez()) do
        if name == v then
            return true
        end
    end
    return false
end



local function sudolist(msg)
text = "*?? ŞÇÆãå ÇáãØæÑíä : *\n"
local i = 1
for v,user in pairs(_config.sudo_users) do
text = text..i..'- '..(user[2] or '')..' ? ('..user[1]..')\n'
i = i +1
end
return text
end


local function chat_list(msg)
i = 1
local data = load_data(_config.moderation.data)
local groups = 'groups'
if not data[tostring(groups)] then
return 'áõÂ íó?ÌòÏö ãÌòã?ÚòÂÊ ãİóÚòáõÉ ÍòÂáõíóÂ .'
end
local message = '?? ŞÜÇÆãÜå ÇáÜßÜÑæÈÜÇÊ :\n\n'
for k,v in pairsByKeys(data[tostring(groups)]) do
local group_id = v
if data[tostring(group_id)] then
settings = data[tostring(group_id)]['settings']
end
for m,n in pairsByKeys(settings) do
if m == 'set_name' then
name = n:gsub("", "")
group_name_id = check_markdown(name).. ' \n\n`*` ÇíÏí ? (`' ..group_id.. '`)\n'

group_info = i..' Ü '..group_name_id

i = i + 1
end
end
message = message..group_info
end
return message
end

local function chat_num(msg)
i = 1
local data = load_data(_config.moderation.data)
local groups = 'groups'
if not data[tostring(groups)] then
return 'áõÂ íó?ÌòÏö ãÌòã?ÚòÂÊ ãİóÚòáõÉ ÍòÂáõíóÂ .'
end
local message = '?? ŞÜÇÆãÜå ÇáÜßÜÑæÈÜÇÊ :\n\n'
for k,v in pairsByKeys(data[tostring(groups)]) do
local group_id = v
if data[tostring(group_id)] then
settings = data[tostring(group_id)]['settings']
end
for m,n in pairsByKeys(settings) do
if m == 'set_name' then
name = n:gsub("", "")
i = i + 1
end
end
end
return '?? ÚÏÏ ÇáãÌãæÚÇÊ ÇáãİÚáÉ  : `'..i..'` ??'
end






 function botrem(msg)
local data = load_data(_config.moderation.data)
data[tostring(msg.to.id)] = nil
save_data(_config.moderation.data, data)
local groups = 'groups'
if not data[tostring(groups)] then
data[tostring(groups)] = nil
save_data(_config.moderation.data, data)
end
data[tostring(groups)][tostring(msg.to.id)] = nil
save_data(_config.moderation.data, data)
tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end



local function action_by_reply(arg, data)
local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then

if cmd == "ÇáÑÊÈå" then
local function visudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = "á?Â?í???Ì?Ï? ã?Ú?Ñ?İ?!"
end


if data.id_ == our_id  then
rank = 'åĞÇ ÇáÈæÊ ?????'
elseif is_sudo1(data.id_) then
rank = 'ÇáãØæÑ åĞÇ ??'
elseif is_owner1(arg.chat_id,data.id_) then
rank = 'ãÏíÑ ÇáãÌãæÚå ??'
elseif is_mod1(arg.chat_id,data.id_) then
rank = ' ÇÏãä İí ÇáÈæÊ ??'
elseif is_whitelist(data.id_, arg.chat_id)  then
rank = 'ÚÖæ ããíÒ ??'
else
rank = 'ãÌÑÏ ÚÖæ ??'
end
local rtba = '?? ÇÓãå ? : '..check_markdown(data.first_name_)..'\n??ãÚÑİå ? : '..user_name..' \n?? ÑÊÈÊå ? : '..rank



return tdcli.sendMessage(arg.chat_id, 1, 0, rtba, 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end

if cmd == "ÑİÚ ãØæÑ" then
local function visudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Çäå ÈÇáÊÃßíÏ ãØæÑ ??_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})

save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Êã ÊÑŞíÊå áíÕÈÍ ãØæÑ ??_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "ÊäÒíá ãØæÑ" then
local function desudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
local nameid = index_function(tonumber(data.id_))

if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Çäå ÈÇáÊÃßíÏ áíÓ ãØæÑ ??_', 0, "md")
end
table.remove(_config.sudo_users, nameid)

save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Êã ÊäÒíáå ãä ÇáãØæÑíä ??_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
else
return tdcli.sendMessage(data.chat_id_, "", 0, "*?? áÇ íæÌÏ", 0, "md")
end
end

local function action_by_username(arg, data)
local cmd = arg.cmd
if not arg.username then return false end
if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "ÑİÚ ãØæÑ" then
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Çäå ÈÇáÊÃßíÏ ãØæÑ ??_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})
save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Êã ÊÑŞíÊå áíÕÈÍ ãØæÑ ??_', 0, "md")
end
if cmd == "ÊäÒíá ãØæÑ" then
if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Çäå ÈÇáÊÃßíÏ áíÓ ãØæÑ ??_', 0, "md")
end
local nameid = index_function(tonumber(data.id_))

table.remove(_config.sudo_users, nameid)

--table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Êã ÊäÒíáå ãä ÇáãØæÑíä ??_', 0, "md")
end
else
return tdcli.sendMessage(arg.chat_id, "", 0, "_??  áÇ íæÌÏ _", 0, "md")
end
end

local function action_by_id(arg, data)
local cmd = arg.cmd
if not tonumber(arg.user_id) then return false end
if data.id_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end

if cmd == "ÑİÚ ãØæÑ" then
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Çäå ÈÇáÊÃßíÏ ãØæÑ ??_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})
save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Êã ÊÑŞíÊå áíÕÈÍ ãØæÑ ??_', 0, "md")
end
if cmd == "ÊäÒíá ãØæÑ" then
local nameid = index_function(tonumber(data.id_))

if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Çäå ÈÇáÊÃßíÏ áíÓ ãØæÑ ??_', 0, "md")
end
table.remove(_config.sudo_users, nameid)
save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ : '..user_name..' \n?? _ÇáÇíÏí ?_ : *'..data.id_..'*\n??_ Êã ÊäÒíáå ãä ÇáãØæÑíä ??_', 0, "md")
end
else
return tdcli.sendMessage(arg.chat_id, "", 0, "_?? áÇ íæÌÏ _", 0, "md")
end
end


local function run(msg, matches)
if tonumber(msg.from.id) == SUDO then
if matches[1] == "ÊäÙíİ ÇáÈæÊ" then
run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
run_bash("rm -rf ~/.telegram-cli/data/photo/*")
run_bash("rm -rf ~/.telegram-cli/data/animation/*")
run_bash("rm -rf ~/.telegram-cli/data/video/*")
run_bash("rm -rf ~/.telegram-cli/data/audio/*")
run_bash("rm -rf ~/.telegram-cli/data/voice/*")
run_bash("rm -rf ~/.telegram-cli/data/temp/*")
run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
run_bash("rm -rf ~/.telegram-cli/data/document/*")
run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
return "*??Êã ÍĞİ ÇáĞÇßÑå ÇáãÄŞÊå İí ÇáÊíÌí*"
end
if matches[1] == "ÑİÚ ãØæÑ" then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="ÑİÚ ãØæÑ"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="ÑİÚ ãØæÑ"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ÑİÚ ãØæÑ"})
end
end
if matches[1] == "ÊäÒíá ãØæÑ" then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="ÊäÒíá ãØæÑ"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="ÊäÒíá ãØæÑ"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ÊäÒíá ãØæÑ"})
end
end
end


if msg.to.type == 'channel' or msg.to.type == 'chat' then

if matches[1] == "ÇáÑÊÈå" and not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="ÇáÑÊÈå"})
end

local data = load_data(_config.moderation.data)
local groups = 'groups'
if data[tostring(groups)] then
settings = data[tostring(msg.to.id)]['settings'] 
end


if matches[1] == 'ÇĞÇÚå ÚÇã' and is_sudo(msg) then		
if (not redis:get('lock_brod') or redis:get('lock_brod')=="no" ) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "??åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ " 
end
end
local list = redis:smembers('users')
for i = 1, #list do
tdcli.sendMessage(list[i], 0, 0, matches[2], 0)			
end
local data = load_data(_config.moderation.data)		
local bc = matches[2]			
local i =1 
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
i=i+1
end
tdcli.sendMessage(msg.to.id, 0, 0, '?? Êã ÇĞÇÚå Çáì '..i..' ãÌãæÚÇÊ ??', 0)			
tdcli.sendMessage(msg.to.id, 0, 0,'?? Êã ÇĞÇÚå Çáì `'..redis:scard('users')..'` ãä ÇáãÔÊÑßíä ????', 0)	
end

if matches[1] == 'ÇĞÇÚå ÎÇÕ' and is_sudo(msg) then		
if (not redis:get('lock_brod') or redis:get('lock_brod')=="no" ) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "??åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ " 
end
end


local list = redis:smembers('users')
for i = 1, #list do
tdcli.sendMessage(list[i], 0, 0, matches[2], 0)			
end
tdcli.sendMessage(msg.to.id, 0, 0,'?? Êã ÇĞÇÚå Çáì `'..redis:scard('users')..'` ãä ÇáãÔÊÑßíä ????', 0)	
end

if matches[1] == 'ÇĞÇÚå' and is_sudo(msg) then		
if (not redis:get('lock_brod') or redis:get('lock_brod')=="no" ) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "??åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ  " 
end
end

local data = load_data(_config.moderation.data)		
local bc = matches[2]			
local i =1 
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
i=i+1
end
tdcli.sendMessage(msg.to.id, 0, 0, '?? Êã ÇĞÇÚå Çáì '..i..' ãÌãæÚÇÊ ??', 0)			

end

if matches[1] == 'ÇáãØæÑíä' and is_sudo(msg) then
return sudolist(msg)
end

if matches[1] == 'ÇáãÌãæÚÇÊ' and is_sudo(msg) then
return chat_num(msg)
end

if matches[1] == 'ŞÇÆãå ÇáãÌãæÚÇÊ' and is_sudo(msg) then
return chat_list(msg)
end

if matches[1] == 'ÊÚØíá' and string.match(matches[2], '^-%d+$') and is_sudo(msg) then
local data = load_data(_config.moderation.data)
-- Group configuration removal
data[tostring(matches[2])] = nil
save_data(_config.moderation.data, data)
local groups = 'groups'
if not data[tostring(groups)] then
data[tostring(groups)] = nil
save_data(_config.moderation.data, data)
end
data[tostring(groups)][tostring(matches[2])] = nil
save_data(_config.moderation.data, data)
tdcli.sendMessage(matches[2], 0, 1, "Êã ÊÚØíá ÇáÈæÊ ãä ŞÈá ÇáãØæÑ ", 1, 'html')
tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
return '_ÇáãÌãæÚå_ *'..matches[2]..'* _Êã ÊÚØíáåÇ_'
end
if matches[1] == '=' then
tdcli.sendMessage(msg.to.id, msg.id, 1, _config.info_text, 1, 'html')
end
if matches[1] == 'ÇáãÏÑÇÁ' and is_sudo(msg) then
return adminlist(msg)
end
if matches[1] == 'ÒÚ' and is_sudo(msg) then
tdcli.sendMessage(msg.to.id, msg.id, 1, 'Çæß ÈÇí ??????????', 1, 'html')
tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
botrem(msg)

end   

if matches[1] == "ßÔİ ÇáÇÏãä" and not matches[2] and is_owner(msg) then
local checkmod = false
tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
local secchk = true
for k,v in pairs(b.members_) do
if v.user_id_ == tonumber(our_id) then
secchk = false
end
end
if secchk then
return tdcli.sendMessage(msg.to.id, msg.id, 1, '?? ßáÇ ÇáÈæÊ áíÓ ÇÏãä İí ÇáãÌãæÚÉ ??', 1, "md")
else
return tdcli.sendMessage(msg.to.id, msg.id, 1, '?? äÚã Çäå ÇÏãä İí ÇáãÌãæÚÉ ????', 1, "md")
end
end, nil)
end

if is_sudo(msg) and  matches[1] == "ÑÇÓá" then
if matches[2] and string.match(matches[2], '@[%a%d]') then
local function rasll (extra, result, success)
if result.id_ then
if result.type_.user_.username_ then
user_name = '@'..check_markdown(result.type_.user_.username_)
else
user_name = check_markdown(result.first_name_)
end
tdcli.sendMessage(msg.chat_id_, 0, 1, '?? Êã ÇÑÓÇá ÇáÑÓÇáÉ áÜ '..user_name..' ??????????' , 1, 'md')
tdcli.sendMessage(result.id_, 0, 1, extra.msgx, 1, 'html')
end
end
return   tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, rasll, {msgx=matches[3]})
elseif matches[2] and string.match(matches[2], '^%d+$') then
tdcli.sendMessage(msg.to.id, 0, 1, '?? Êã ÇÑÓÇá ÇáÑÓÇáÉ áÜ ['..matches[2]..'] ??????????' , 1, 'html')
tdcli.sendMessage(matches[2], 0, 1, matches[3], 1, 'html')
end
end


if matches[1] == "ãæÇáíÏí" then
local kyear = tonumber(os.date("%Y"))
local kmonth = tonumber(os.date("%m"))
local kday = tonumber(os.date("%d"))
--
local agee = kyear - matches[2]
local ageee = kmonth - matches[3]
local ageeee = kday - matches[4]

return  " ???? ãÑÍÈÇ ÚÒíÒí"
.."\n???? áŞÏ ŞãÊ ÈÍÓÈ ÚãÑß ??????  \n\n"

.."?? "..agee.." Óäå\n"
.."?? "..ageee.." ÇÔåÑ \n"
.."?? "..ageeee.." íæã \n\n"

end
-------

if matches[1]== 'ÑÓÇÆáí' or matches[1]=='ÑÓÇíáí' then
local msgs = tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0)
return '??? ÚÏÏ ÑÓÇÆáß ÇáãÑÓáå : `'..msgs..'` ÑÓÇáå \n\n'
end
if matches[1]:lower() == 'ãÚáæãÇÊí' or matches[1]:lower() == 'ãæŞÚí'  then
if msg.from.first_name then
if msg.from.username then username = '@'..check_markdown(msg.from.username)
else username = '<i>ãÇ ãÓæí  ????</i>'
end
if is_sudo(msg) then rank = 'ÇáãØæÑ ãÇáÊí ??'
elseif is_owner(msg) then rank = 'ãÏíÑ ÇáãÌãæÚå ??'
elseif is_sudo(msg) then rank = 'ÇÏÇÑí İí ÇáÈæÊ ??'
elseif is_mod(msg) then rank = 'ÇÏãä İí ÇáÈæÊ ??'
elseif is_whitelist(msg.from.id,msg.to.id)  then rank = 'ÚÖæ ããíÒ ??'
else rank = 'ãÌÑÏ ÚÖæ ??'
end
local text = '*??????¦ ÇåÜáÇ ÈÜß ÚÒíÒí :\n\n?? ÇáÇÓã ÇáÇæá :* _'..msg.from.first_name
..'_\n*?? ÇáÇÓã ÇáËÇäí :* _'..(msg.from.last_name or "---")
..'_\n*?? ÇáãÚÑİ :* '..username
..'\n*?? ÇáÇíÏí :* ( `'..msg.from.id
..'` )\n*?? ÇíÏí ÇáßÑæÈ :* ( `'..msg.to.id
..'` )\n*?? ãæŞÚß :* _'..rank
..'_\n*?? ãÜØÜæÑ ÇáÈæÊ *: '..sudouser..'\n??????'
tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'md')
end
end




if matches[1] == "ÇáÇæÇãÑ" then
if not is_mod(msg) then return "?? ááÇÏÇÑííä İŞØ ??" end
local text = [[
?? ãÑÍÈÇ Èß ÚÒíÒí ÇáÇæÇãÑ????
???`?????`
??`ã1` ? ÇæÇãÑ ÇáÇÏÇÑå  
??`ã2` ? ÇæÇãÑ ÇÚÏÇÏÊ ÇáßÑæÈ
??`ã3` ? ÇæÇãÑ ÇáÍãÇíÉ 
??`ã4` ? ÇáÇæÇãÜÑ ÇáÜ?ÜÇãå 
??`ã5` ? ÇæÇãÑ ÇÖÇİå ÑÏæÏ
??`ã6` ? ÇæÇãÑ ÇáÒÎÑİå    
??`ã ÇáãØæÑ` ? ááãØæÑ İŞØ 
???`?????`
??`ÇáÜãÜØÜæÑ`  ?  ]]..sudouser

return tdcli.sendMessage(msg.to.id, msg.id, 1, text, 1, 'md')

end

if matches[1]== 'ã1' then
if not is_mod(msg) then return "?? ááÇÏÇÑííä İŞØ ??" end
local text =[[
??ãÑÍÈÇ Èß İí ÇáÇæÇãÑ ÇáÇæáì
???`?????`
???ÇæÇãÑ ÇáÊäÒíá æÇáÑİÚ ÈÜ ÇáÈæÊ????
???`?????`
??`ÑİÚ ÇÏãä `? áÑİÚ ÇÏãä 
??`ÊäÒíá ÇÏãä` ? áÊäÒíá ÇÏãä
??`ÑİÚ ÚÖæ ããíÒ` ? áÑİÚ ããíÒ 
??`ÊäÒíá ÚÖæ ããíÒ`?áÊäÒíá ããíÒ 
??` ÇáÇÏãäíå` ? áÚÑÖ ÇáÇÏãäíå
??`ÇáãÏÑÇÁ` ? áÚÑÖ ÇáãÏÑÇÁ                       
???`?????`
?? ÇæÇãÑ ÇáØÑÏ æÇáÍÖÑ ????
???`?????`
??`ØÑÏ ÈÇáÑÏ `? áØÑÏ ÇáÚÖæ 
??`ÍÙÑ ÈÇáÑÏ` ? áÍÙÑ æØÑÏ 
??`ÇáÛÇÁ ÇáÍÙÑ` ? áÇáÛÇÁ ÇáÍÙÑ 
??`ãäÚ` ? áãäÚ ßáãå İí ÇáßÑæÈ
??`ÇáÛÇÁ ãäÚ` ? áÇáÛÇÁ ãäÚ Çáßáãå  
??`ßÊã` ? áßÊã ÚÖæ  
??`ÇáÛÇÁ ÇáßÊã`? áÇáÛÇÁ ÇáßÊã
???`?????`
??`ÇáÜãÜØÜæÑ`  ?  ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== 'ã2' then
if not is_mod(msg) then return "?? ááÇÏÇÑííä İŞØ ??" end
local text = [[
?????ãÑÍÈÇ ÚÒíÒí ÇæÇãÑ ÇÚÏÇÏÊ????
???`?????`
????? ÇæÇãÑ ÇáæÖÚ ááãÌãæÚå????
???`?????`
??`ÖÚ ÇáÊÑÍíÈ`?áæÖÚ ÊÑÍíÈ  
??` ÖÚ ŞæÇäíä`? áæÖÚ ŞæÇäíä 
??` ÖÚ æÕİ` ? áæÖÚ æÕİ    
??` ÇáÑÇÈØ` ? áÚÑÖ ÇáÑÇÈØ  
???`?????`
????? ÇæÇãÑ ÑÄíå ÇáÇÚÏÇÏÇÊ ????
???`?????`
?? `ÇáŞæÇäíä `?áÚÑÖ ÇáŞæÇäíä  
?? `ÇáãßÊæãíä` ?áÚÑÖ ÇáãßÊæãíä 
?? `ÇáãØæÑ `? áÚÑÖ ÇáãØæÑ 
?? `ãÚáæãÇÊí` ?áÚÑÖ ãÚáæãÇÊß  
?? `ÇáÍãÇíå` ? áÚÑÖ ÇÚÏÇÏÇÊ 
??`ÇáæÓÇÆØ `?áÚÑÖ  ÇáãíÏíÇ 
??`ÇáãÌãæÚå` ?ãÚáæãÇÊ ÇáãÌãæÚå 
???`?????`
??`ÇáÜãÜØÜæÑ`  ? ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== 'ã3' then
if not is_mod(msg) then return "?? ááÇÏÇÑííä İŞØ ??" end
local text = [[
???ãÑÍÈÇ ÚÒíÒí ÇæÇãÑ ÍãÇíå????
???`?????`
????? ÇæÇãÑ ÍãÇíå ÇáãÌãæÚå ??
???`?????`
??`Şİá? İÊÍ` ? ÇáÊËÈíÊ
??`Şİá? İÊÍ `? ÇáÊÚÏíá
??`Şİá? İÊÍ `? ÇáÈÕãÇÊ
??`Şİá? İÊÍ` ? ÇáÜİíÏíæ
??`Şİá? İÊÍ `? ÇáÜÕæÊ 
???`Şİá? İÊÍ `?  ÇáÜÕæÑ 
??`Şİá? İÊÍ `? ÇáãáÕŞÇÊ
??`Şİá? İÊÍ `? ÇáãÊÍÑßå
??`Şİá? İÊÍ `? ÇáÏÑÏÔå
??`Şİá? İÊÍ `? ÇáãáÕŞÇÊ
??`Şİá? İÊÍ `? ÇáÑæÇÈØ
??`Şİá? İÊÍ `?ÇáÊÇß
??`Şİá? İÊÍ `? ÇáÈæÊÇÊ
??`Şİá? İÊÍ `? ÇáÈæÊÇÊ ÈÇáØÑÏ
??`Şİá? İÊÍ `? ÇáßáÇíÔ
??`Şİá? İÊÍ `? ÇáÊßÑÇÑ
??`Şİá? İÊÍ `? ÇáÊæÌíå
??`Şİá? İÊÍ `? ÇáÌåÇÊ 
??`Şİá? İÊÍ `? ÇáãÌãæÚå 
??`Şİá? İÊÍ `? ÇáÜßÜá
???`?????`
??`ÊİÚíá  ? ÊÚØíá `? ÇáÊÑÍíÈ 
??` ÊİÚíá ? ÊÚØíá `? ÇáÑÏæÏ 
??` ÊİÚíá ? ÊÚØíá `?ÇáÊÍĞíÑ
??` ÊİÚíá ? ÊÚØíá `? ÇáÇíÏí 
???`?????`
??`ÇáÜãÜØÜæÑ`  ?  ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== 'ã4' then
if not is_mod(msg) then return "?? ááÇÏÇÑííä İŞØ ??" end
local text = [[
????? ãÑÍÈÇ ÚÒíÒí ÇæÇãÑ ÇÖÇİíå???? 
???`?????`
?? ãÚáæãÇÊß ÇáÔÎÕíå ????
?? `ÇÓãí` ? ÚÑÖ ÇÓãß ??
?? `ÑÊÈÊí` ? áÚÑÖ ÑÊÈÊß ??
?? `ÇáÑÊÈå ` ?  áÚÑÖ ÇáÑÊÈå ??
?? `ãÚÑİí` ? áÚÑÖ ãÚÑİß ??
?? `ÇíÏíí `? áÚÑÖ ÇíÏíß ??
??`ÑŞãí ` ?  áÚÑÖ ÑŞãß  ??
???`?????` 
??`ÇæÇãÑ` ÇáÊÍÔíÔ ????
???`?????` 
??`ÊÍÈ` + (ÇÓã ÇáÔÎÕ)
??` ÈæÓ` + (ÇÓã ÇáÔÎÕ) 
??` ßæá `+ (ÇÓã ÇáÔÎÕ) 
??` ßáå `+ ÇáÑÏ + (ÇáßáÇã) 
???`?????`
??`ÇáÜãÜØÜæÑ`  ? ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== "ã ÇáãØæÑ" then
if not is_sudo(msg) then return "?? ááãØæíä İŞØ ??" end
local text = [[
???ãÑÍÈÇ ãØæÑí ÇæÇãÑß ????
???`?????` 
?? `ÊİÚíá`  ? áÊİÚíá ÇáÈæÊ 
?? `ÊÚØíá` ? áÊÚØíá ÇáÈæÊ 
??`ÊİÚíá ÇáÇĞÚå` ? áÊÔÛíá ?
??[ ÇáÇĞÚå ÇáãØæÑ áíÓ ÇÓÇÓí] 
??`ÊÚØíá ÇáÇĞÚå` ? áÇíŞÇİ ? 
??[ÇáÇĞÚå Ú ÇáãØæÑ áíÓ ÇÓÇÓí ]
??` ÇĞÇÚå ` ? äÔÑ İí ÇáßÑæÈÇÊ
??[ÇÓã ÈæÊß] ÛÇÏÑ ?áØÑÏ ÇáÈæÊ
??` ãÓÍ ÇáÇÏãäíå` ? áãÓÍ ÇÏãäíå 
??` ãÓÍ ÇáãÏÑÇÁ`?áãÓÍ ÇÏÇÑííä 
??` ÊÍÏíË` ? áÊÍÏíË ÇáãáİÇÊ 
??`ÇæÇãÑ ÇáãáİÇÊ` ? áÚÑÖ ÇáÇæÇãÑ
??`ÇáãÌãæÚÇÊ`?áÚÑÖ ãÌãæÚÇÊ
??`ÇáãÔÊÑßíä`?áÚÑÖ ÇáãÔÊÑßíä
??`ÇĞÇÚå ÎÇÕ` ? áÇĞÇÚå İí ?
??[ÎÇÕ ÇáÈæÊ ááãØæÑ ÇáÇÓÇÓí] 
??`ÑİÚ?ÊäÒíá` ãØæÑ ? ?
??[áÑİÚ æÊäÒíá ãØæÑ İí ÇáÈæÊ ]
??`ÇĞÇÚå ÚÇã` ?áÇĞÇÚÉ áãØæÑ 
??`ÊäÙíİ ÇáÈæÊ` ? áİÑãÊå ÇáÈæÊ 
??`ŞÇÆãå ÇáãÌãæÚÇÊ` ? áÚÑÖ ?
??[ÇáãÌãæÚÇÊ ÇáãİÚáå Èá ÇÓã ]
???`?????`
??`ÇáÜãÜØÜæÑ`  ?]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== 'ã5' then
if not is_owner(msg) then return "?? ááãÏÑÇÁ İŞØ ??" end

local text = [[
?????ãÑÍÈÇ ÚÒíÒí ÇæÇãÑ ÇáÑÏæÏ ????
???`?????` 
????ÇæÇãÜÑ ÇáãÏíÑ İŞØ ??
?? `ÇáÑÏæÏ` ?  áÚÑÖ ÇáÑÏæÏ ÇáãËÈÊå
?? `ÇÖİ ÑÏ` ?  ÃÖÇİÉÑÏ ÌÏíÏ
?? `ãÓÍ ÑÏ`   ? ÇáãÑÇÏ ãÓÍå
?? `ãÓÍ ÇáÑÏæÏ` ? áãÓÍ Çáßá
???`?????` 
????ÇæÇãÜÑ ÇáãØæÑ İŞØ ??
?? `ÇáÑÏæÏ ÇáÚÇãå` ?  áÚÑÖ ÇáÑÏæÏ 
?? `ÇÖİ ÑÏ ááßá `?  ÃÖÇİÉÑÏ ÌÏíÏ
?? `ãÓÍ ÑÏ ÚÇã `? ÇáãÑÇÏ ãÓÍå
?? `ãÓÍ ÇáÑÏæÏ ÇáÚÇãå` ? áãÓÍ Çáßá
???`?????`
??`ÇáÜãÜØÜæÑ`  ?  ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== "ã6" then
if not is_mod(msg) then return "?? ááÇÏÇÑííä İŞØ ??" end
local text = [??? ÇæÇãÑ ÇáÒÎÑİÉÉ ??

?? ÒÎÑİ + Çáßáãå ÇáãÑÇÏ ÒÎÑİÊåÇ ÈÇáÇäßáÔ ??
?? ÒÎÑİå + Çáßáãå ÇáãÑÇÏ ÒÎÑİÊåÇ ÈÇáÚÑÈí ??
??`ÇáÜãÜØÜæÑ`  ?  ]]..sudouser

return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== "ÇæÇãÑ ÇáãáİÇÊ" then
if tonumber(msg.from.id) ~= tonumber(SUDO) then return "??åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ ??" end
local text = [[???? ÇæÇãÑ ÇáãáİÇÊ ??
?? ? /p  áÚÑÖ ŞÇÆãå ÇáãáİÇÊ  
??? /p + ÇÓã Çáãáİ ÇáãÑÇÏ ÊİÚíáå 
??? /p - ÇÓã Çáãáİ ÇáãÑÇÏ ÊÚØíáå 
??? sp + ÇáÇÓã | áÇÑÓÇá Çáãáİ Çáíß 
??? dp + ÇÓã Çáãáİ ÇáãÑÇÏ ÍĞİå 
??? sp all | áÇÑÓÇáß ßá ãáİÇÊ 
???ÊÍÏíË ÇáÓæÑÓ ? íÍÏË? 
???[ÇáÓæÑÓ Çáì ÇáÇÕÏÇÑ ÇáÌÏíÏ] 
???äÓÎå ÇÍÊíÇØíå ? áÌáÈ ? 
???äÓÎå ÇáßÑæÈÇÊ áÍİÙ Çãä ÇáÈæÊ] 
???ÑİÚ äÓÎå ÇÍÊíÇØíå ? áÑİÚ? 
???[ ÇáäÓÎå ÇáÇÍÊíÇØíå ]
??? save + ÇÓã Çáãáİ ? áÑİÚ? 
??[ ÇáãáİÇÊ ãä ÇáÊáí Çáì ÓíÑİÑ ]
??`ÇáÜãÜØÜæÑ`  ?  ]]..sudouser

return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end



if matches[1] == "ÇáãØæÑ" then
local text = [[
??- ÇåÜáÇ ÈÜß ÚÜÒíÜÒí ??

??- ÈæÊ ÍãÇíÉ ÇáãÌãæÚÇÊ ÇáÇİÖá 

??- áÊİÚíá ÇáÈæÊ İí ãÌãæÚÊß ÑÇÓá 

??- ááÇÓÊİÓÇÑ ÑÇÓá ÇáãØæÑ

??- ?E? @kazzrr|| ?  ]]..sudouser
return tdcli.sendMessage(msg.to.id, msg.id, 1, text, 1, 'md')

end

end


end

return { 
patterns = {   
"^(ßÔİ ÇáÇÏãä)$", 
"^(ã ÇáãØæÑ)$", 
"^(ã5)$", 
"^(ã6)$", 
"^(ÇæÇãÑ ÇáãáİÇÊ)$", 
"^(ÇáÇæÇãÑ)$", 
"^(ã1)$", 
"^(ã2)$", 
"^(ã3)$", 
"^(ã4)$", 
"^(ÇáãØæÑ)$", 
"^(ÇáÑÊÈå)$", 
"^(ÑİÚ ãØæÑ)$", 
"^(ÊäÒíá ãØæÑ)$",
"^(ÇáãØæÑíä)$",
"^(ÑİÚ ãØæÑ) (.*)$",
"^(ÊäÒíá ãØæÑ) (.*)$",
"^(=)$",
"^(ŞÇÆãå ÇáãÌãæÚÇÊ)$",
"^(ÇáãÌãæÚÇÊ)$",
"^(ÑÓÇÆáí)$",
"^(ÑÓÇíáí)$",
"^(ãÚáæãÇÊí)$",
"^(ãæŞÚí)$",
"^(ÊäÙíİ ÇáÈæÊ)$",
"^(ÊİÚíá) (.*)$",
"^(ÊÚØíá) (.*)$",
"^(ÇĞÇÚå ÚÇã) (.*)$",
"^(ÇĞÇÚå ÎÇÕ) (.*)$",
"^(ÇĞÇÚå) (.*)$",
"^(ÇÖÇİå) (@[%a%d%_]+)$",
"^(ÑÇÓá) (@[%a%d%_]+) (.*)$",
"^(ÑÇÓá) (%d+) (.*)$",
"^(ÒÚíã ÛÇÏÑ)$",
"^(ãæÇáíÏí) (.+)/(.+)/(.+)",
"^!!tgservice (.+)$",

}, 
run = run,
}