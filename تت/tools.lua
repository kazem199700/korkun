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
text = "*?? ����� �������� : *\n"
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
return '��� ��?���� ����?���� �������� �������� .'
end
local message = '?? ������� ����������� :\n\n'
for k,v in pairsByKeys(data[tostring(groups)]) do
local group_id = v
if data[tostring(group_id)] then
settings = data[tostring(group_id)]['settings']
end
for m,n in pairsByKeys(settings) do
if m == 'set_name' then
name = n:gsub("", "")
group_name_id = check_markdown(name).. ' \n\n`*` ���� ? (`' ..group_id.. '`)\n'

group_info = i..' � '..group_name_id

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
return '��� ��?���� ����?���� �������� �������� .'
end
local message = '?? ������� ����������� :\n\n'
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
return '?? ��� ��������� �������  : `'..i..'` ??'
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

if cmd == "������" then
local function visudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = "�?�?�???�?�? �?�?�?�?!"
end


if data.id_ == our_id  then
rank = '��� ����� ?????'
elseif is_sudo1(data.id_) then
rank = '������ ��� ??'
elseif is_owner1(arg.chat_id,data.id_) then
rank = '���� �������� ??'
elseif is_mod1(arg.chat_id,data.id_) then
rank = ' ���� �� ����� ??'
elseif is_whitelist(data.id_, arg.chat_id)  then
rank = '��� ���� ??'
else
rank = '���� ��� ??'
end
local rtba = '?? ���� ? : '..check_markdown(data.first_name_)..'\n??����� ? : '..user_name..' \n?? ����� ? : '..rank



return tdcli.sendMessage(arg.chat_id, 1, 0, rtba, 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end

if cmd == "��� ����" then
local function visudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ ��� �������� ���� ??_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})

save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ �� ������ ����� ���� ??_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "����� ����" then
local function desudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
local nameid = index_function(tonumber(data.id_))

if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ ��� �������� ��� ���� ??_', 0, "md")
end
table.remove(_config.sudo_users, nameid)

save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ �� ������ �� �������� ??_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
else
return tdcli.sendMessage(data.chat_id_, "", 0, "*?? �� ����", 0, "md")
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
if cmd == "��� ����" then
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ ��� �������� ���� ??_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})
save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ �� ������ ����� ���� ??_', 0, "md")
end
if cmd == "����� ����" then
if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ ��� �������� ��� ���� ??_', 0, "md")
end
local nameid = index_function(tonumber(data.id_))

table.remove(_config.sudo_users, nameid)

--table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ �� ������ �� �������� ??_', 0, "md")
end
else
return tdcli.sendMessage(arg.chat_id, "", 0, "_??  �� ���� _", 0, "md")
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

if cmd == "��� ����" then
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ ��� �������� ���� ??_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})
save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ �� ������ ����� ���� ??_', 0, "md")
end
if cmd == "����� ����" then
local nameid = index_function(tonumber(data.id_))

if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ ��� �������� ��� ���� ??_', 0, "md")
end
table.remove(_config.sudo_users, nameid)
save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _����� ?_ : '..user_name..' \n?? _������ ?_ : *'..data.id_..'*\n??_ �� ������ �� �������� ??_', 0, "md")
end
else
return tdcli.sendMessage(arg.chat_id, "", 0, "_?? �� ���� _", 0, "md")
end
end


local function run(msg, matches)
if tonumber(msg.from.id) == SUDO then
if matches[1] == "����� �����" then
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
return "*??�� ��� ������� ������� �� ������*"
end
if matches[1] == "��� ����" then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="��� ����"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="��� ����"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="��� ����"})
end
end
if matches[1] == "����� ����" then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="����� ����"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="����� ����"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="����� ����"})
end
end
end


if msg.to.type == 'channel' or msg.to.type == 'chat' then

if matches[1] == "������" and not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="������"})
end

local data = load_data(_config.moderation.data)
local groups = 'groups'
if data[tostring(groups)] then
settings = data[tostring(msg.to.id)]['settings'] 
end


if matches[1] == '����� ���' and is_sudo(msg) then		
if (not redis:get('lock_brod') or redis:get('lock_brod')=="no" ) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "??��� ������� ������ ������� ��� " 
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
tdcli.sendMessage(msg.to.id, 0, 0, '?? �� ����� ��� '..i..' ������� ??', 0)			
tdcli.sendMessage(msg.to.id, 0, 0,'?? �� ����� ��� `'..redis:scard('users')..'` �� ��������� ????', 0)	
end

if matches[1] == '����� ���' and is_sudo(msg) then		
if (not redis:get('lock_brod') or redis:get('lock_brod')=="no" ) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "??��� ������� ������ ������� ��� " 
end
end


local list = redis:smembers('users')
for i = 1, #list do
tdcli.sendMessage(list[i], 0, 0, matches[2], 0)			
end
tdcli.sendMessage(msg.to.id, 0, 0,'?? �� ����� ��� `'..redis:scard('users')..'` �� ��������� ????', 0)	
end

if matches[1] == '�����' and is_sudo(msg) then		
if (not redis:get('lock_brod') or redis:get('lock_brod')=="no" ) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "??��� ������� ������ ������� ���  " 
end
end

local data = load_data(_config.moderation.data)		
local bc = matches[2]			
local i =1 
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
i=i+1
end
tdcli.sendMessage(msg.to.id, 0, 0, '?? �� ����� ��� '..i..' ������� ??', 0)			

end

if matches[1] == '��������' and is_sudo(msg) then
return sudolist(msg)
end

if matches[1] == '���������' and is_sudo(msg) then
return chat_num(msg)
end

if matches[1] == '����� ���������' and is_sudo(msg) then
return chat_list(msg)
end

if matches[1] == '�����' and string.match(matches[2], '^-%d+$') and is_sudo(msg) then
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
tdcli.sendMessage(matches[2], 0, 1, "�� ����� ����� �� ��� ������ ", 1, 'html')
tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
return '_��������_ *'..matches[2]..'* _�� �������_'
end
if matches[1] == '=' then
tdcli.sendMessage(msg.to.id, msg.id, 1, _config.info_text, 1, 'html')
end
if matches[1] == '�������' and is_sudo(msg) then
return adminlist(msg)
end
if matches[1] == '��' and is_sudo(msg) then
tdcli.sendMessage(msg.to.id, msg.id, 1, '��� ��� ??????????', 1, 'html')
tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
botrem(msg)

end   

if matches[1] == "��� ������" and not matches[2] and is_owner(msg) then
local checkmod = false
tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
local secchk = true
for k,v in pairs(b.members_) do
if v.user_id_ == tonumber(our_id) then
secchk = false
end
end
if secchk then
return tdcli.sendMessage(msg.to.id, msg.id, 1, '?? ��� ����� ��� ���� �� �������� ??', 1, "md")
else
return tdcli.sendMessage(msg.to.id, msg.id, 1, '?? ��� ��� ���� �� �������� ????', 1, "md")
end
end, nil)
end

if is_sudo(msg) and  matches[1] == "����" then
if matches[2] and string.match(matches[2], '@[%a%d]') then
local function rasll (extra, result, success)
if result.id_ then
if result.type_.user_.username_ then
user_name = '@'..check_markdown(result.type_.user_.username_)
else
user_name = check_markdown(result.first_name_)
end
tdcli.sendMessage(msg.chat_id_, 0, 1, '?? �� ����� ������� �� '..user_name..' ??????????' , 1, 'md')
tdcli.sendMessage(result.id_, 0, 1, extra.msgx, 1, 'html')
end
end
return   tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, rasll, {msgx=matches[3]})
elseif matches[2] and string.match(matches[2], '^%d+$') then
tdcli.sendMessage(msg.to.id, 0, 1, '?? �� ����� ������� �� ['..matches[2]..'] ??????????' , 1, 'html')
tdcli.sendMessage(matches[2], 0, 1, matches[3], 1, 'html')
end
end


if matches[1] == "�������" then
local kyear = tonumber(os.date("%Y"))
local kmonth = tonumber(os.date("%m"))
local kday = tonumber(os.date("%d"))
--
local agee = kyear - matches[2]
local ageee = kmonth - matches[3]
local ageeee = kday - matches[4]

return  " ???? ����� �����"
.."\n???? ��� ��� ���� ���� ??????  \n\n"

.."?? "..agee.." ���\n"
.."?? "..ageee.." ���� \n"
.."?? "..ageeee.." ��� \n\n"

end
-------

if matches[1]== '������' or matches[1]=='������' then
local msgs = tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0)
return '??? ��� ������ ������� : `'..msgs..'` ����� \n\n'
end
if matches[1]:lower() == '��������' or matches[1]:lower() == '�����'  then
if msg.from.first_name then
if msg.from.username then username = '@'..check_markdown(msg.from.username)
else username = '<i>�� ����  ????</i>'
end
if is_sudo(msg) then rank = '������ ����� ??'
elseif is_owner(msg) then rank = '���� �������� ??'
elseif is_sudo(msg) then rank = '����� �� ����� ??'
elseif is_mod(msg) then rank = '���� �� ����� ??'
elseif is_whitelist(msg.from.id,msg.to.id)  then rank = '��� ���� ??'
else rank = '���� ��� ??'
end
local text = '*????�??� ����� ��� ����� :\n\n?? ����� ����� :* _'..msg.from.first_name
..'_\n*?? ����� ������ :* _'..(msg.from.last_name or "---")
..'_\n*?? ������ :* '..username
..'\n*?? ������ :* ( `'..msg.from.id
..'` )\n*?? ���� ������ :* ( `'..msg.to.id
..'` )\n*?? ����� :* _'..rank
..'_\n*?? ������ ����� *: '..sudouser..'\n????�??'
tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'md')
end
end




if matches[1] == "�������" then
if not is_mod(msg) then return "?? ��������� ��� ??" end
local text = [[
?? ����� �� ����� �������????
???`?????`
??`�1` ? ����� �������  
??`�2` ? ����� ������ ������
??`�3` ? ����� ������� 
??`�4` ? �������� ���?���� 
??`�5` ? ����� ����� ����
??`�6` ? ����� �������    
??`� ������` ? ������ ��� 
???`?????`
??`���������`  ?  ]]..sudouser

return tdcli.sendMessage(msg.to.id, msg.id, 1, text, 1, 'md')

end

if matches[1]== '�1' then
if not is_mod(msg) then return "?? ��������� ��� ??" end
local text =[[
??����� �� �� ������� ������
???`?????`
??�?����� ������� ������ �� �����????
???`?????`
??`��� ���� `? ���� ���� 
??`����� ����` ? ������ ����
??`��� ��� ����` ? ���� ���� 
??`����� ��� ����`?������ ���� 
??` ��������` ? ���� ��������
??`�������` ? ���� �������                       
???`?????`
?? ����� ����� ������ ????
???`?????`
??`��� ����� `? ���� ����� 
??`��� �����` ? ���� ���� 
??`����� �����` ? ������ ����� 
??`���` ? ���� ���� �� ������
??`����� ���` ? ������ ��� ������  
??`���` ? ���� ���  
??`����� �����`? ������ �����
???`?????`
??`���������`  ?  ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== '�2' then
if not is_mod(msg) then return "?? ��������� ��� ??" end
local text = [[
?????����� ����� ����� ������????
???`?????`
??�??? ����� ����� ��������????
???`?????`
??`�� �������`?���� �����  
??` �� ������`? ���� ������ 
??` �� ���` ? ���� ���    
??` ������` ? ���� ������  
???`?????`
??�??? ����� ���� ��������� ????
???`?????`
?? `�������� `?���� ��������  
?? `���������` ?���� ��������� 
?? `������ `? ���� ������ 
?? `��������` ?���� ��������  
?? `�������` ? ���� ������� 
??`������� `?����  ������� 
??`��������` ?������� �������� 
???`?????`
??`���������`  ? ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== '�3' then
if not is_mod(msg) then return "?? ��������� ��� ??" end
local text = [[
???����� ����� ����� �����????
???`?????`
????? ����� ����� �������� ??
???`?????`
??`���? ���` ? �������
??`���? ��� `? �������
??`���? ��� `? �������
??`���? ���` ? ��������
??`���? ��� `? ������ 
???`���? ��� `?  ������ 
??`���? ��� `? ��������
??`���? ��� `? ��������
??`���? ��� `? �������
??`���? ��� `? ��������
??`���? ��� `? �������
??`���? ��� `?�����
??`���? ��� `? �������
??`���? ��� `? ������� ������
??`���? ��� `? �������
??`���? ��� `? �������
??`���? ��� `? �������
??`���? ��� `? ������ 
??`���? ��� `? �������� 
??`���? ��� `? ������
???`?????`
??`�����  ? ����� `? ������� 
??` ����� ? ����� `? ������ 
??` ����� ? ����� `?�������
??` ����� ? ����� `? ������ 
???`?????`
??`���������`  ?  ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== '�4' then
if not is_mod(msg) then return "?? ��������� ��� ??" end
local text = [[
??�??? ����� ����� ����� ������???? 
???`?????`
?? �������� ������� ??�??
?? `����` ? ��� ���� ??
?? `�����` ? ���� ����� ??
?? `������ ` ?  ���� ������ ??
?? `�����` ? ���� ����� ??
?? `����� `? ���� ����� ??
??`���� ` ?  ���� ����  ??
???`?????` 
?�?`�����` ������� ????
???`?????` 
??`���` + (��� �����)
??` ���` + (��� �����) 
??` ��� `+ (��� �����) 
??` ��� `+ ���� + (������) 
???`?????`
??`���������`  ? ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== "� ������" then
if not is_sudo(msg) then return "?? ������� ��� ??" end
local text = [[
???����� ����� ������ ????
???`?????` 
?? `�����`  ? ������ ����� 
?? `�����` ? ������ ����� 
??`����� ������` ? ������ ?
??[ ������ ������ ��� �����] 
??`����� ������` ? ������ ? 
??[������ � ������ ��� ����� ]
??` ����� ` ? ��� �� ��������
??[��� ����] ���� ?���� �����
??` ��� ��������` ? ���� ������ 
??` ��� �������`?���� ������� 
??` �����` ? ������ ������� 
??`����� �������` ? ���� �������
??`���������`?���� �������
??`���������`?���� ���������
??`����� ���` ? ������ �� ?
??[��� ����� ������ �������] 
??`���?�����` ���� ? ?
??[���� ������ ���� �� ����� ]
??`����� ���` ?������ ����� 
??`����� �����` ? ������ ����� 
??`����� ���������` ? ���� ?
??[��������� ������� �� ��� ]
???`?????`
??`���������`  ?]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== '�5' then
if not is_owner(msg) then return "?? ������� ��� ??" end

local text = [[
?????����� ����� ����� ������ ????
???`?????` 
????������ ������ ��� ??
?? `������` ?  ���� ������ �������
?? `��� ��` ?  ������� ����
?? `��� ��`   ? ������ ����
?? `��� ������` ? ���� ����
???`?????` 
????������ ������ ��� ??
?? `������ ������` ?  ���� ������ 
?? `��� �� ���� `?  ������� ����
?? `��� �� ��� `? ������ ����
?? `��� ������ ������` ? ���� ����
???`?????`
??`���������`  ?  ]]..sudouser
return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== "�6" then
if not is_mod(msg) then return "?? ��������� ��� ??" end
local text = [??? ����� �������� ??

?? ���� + ������ ������ ������� �������� ??
?? ����� + ������ ������ ������� ������� ??
??`���������`  ?  ]]..sudouser

return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end

if matches[1]== "����� �������" then
if tonumber(msg.from.id) ~= tonumber(SUDO) then return "??��� ������� ������ ������� ��� ??" end
local text = [[???? ����� ������� ??
?? ? /p  ���� ����� �������  
??? /p + ��� ����� ������ ������ 
??? /p - ��� ����� ������ ������ 
??? sp + ����� | ������ ����� ���� 
??? dp + ��� ����� ������ ���� 
??? sp all | ������� �� ����� 
???����� ������ ? ����? 
???[������ ��� ������� ������] 
???���� �������� ? ���� ? 
???���� �������� ���� ��� �����] 
???��� ���� �������� ? ����? 
???[ ������ ���������� ]
??? save + ��� ����� ? ����? 
??[ ������� �� ����� ��� ����� ]
??`���������`  ?  ]]..sudouser

return tdcli.sendMessage(msg.to.id, 1, 1, text, 1, 'md')

end



if matches[1] == "������" then
local text = [[
??- ����� ��� ������� ??

??- ��� ����� ��������� ������ 

??- ������ ����� �� ������� ���� 

??- ��������� ���� ������

??- ?E? @kazzrr|| ?  ]]..sudouser
return tdcli.sendMessage(msg.to.id, msg.id, 1, text, 1, 'md')

end

end


end

return { 
patterns = {   
"^(��� ������)$", 
"^(� ������)$", 
"^(�5)$", 
"^(�6)$", 
"^(����� �������)$", 
"^(�������)$", 
"^(�1)$", 
"^(�2)$", 
"^(�3)$", 
"^(�4)$", 
"^(������)$", 
"^(������)$", 
"^(��� ����)$", 
"^(����� ����)$",
"^(��������)$",
"^(��� ����) (.*)$",
"^(����� ����) (.*)$",
"^(=)$",
"^(����� ���������)$",
"^(���������)$",
"^(������)$",
"^(������)$",
"^(��������)$",
"^(�����)$",
"^(����� �����)$",
"^(�����) (.*)$",
"^(�����) (.*)$",
"^(����� ���) (.*)$",
"^(����� ���) (.*)$",
"^(�����) (.*)$",
"^(�����) (@[%a%d%_]+)$",
"^(����) (@[%a%d%_]+) (.*)$",
"^(����) (%d+) (.*)$",
"^(���� ����)$",
"^(�������) (.+)/(.+)/(.+)",
"^!!tgservice (.+)$",

}, 
run = run,
}