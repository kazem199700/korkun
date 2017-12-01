local function modadd(msg)

-- superuser and admins only (because sudo are always has privilege)
if not is_sudo(msg) then
return '?? _ÃäÜÊ áÜÓÜÊ ÇáÜãÜØÜæÑ _ ??'
end
local data = load_data(_config.moderation.data)
if data[tostring(msg.to.id)] then
return '?? ÇáãÌãæÚå ÈÇáÊÃßíÏ ?? Êã ÊİÚíáåÇ'

end
-- create data array in moderation.json
data[tostring(msg.to.id)] = {
owners = {},
mods ={},
banned ={},
replay ={},
is_silent_users ={},
filterlist ={},
whitelist ={},
settings = {
set_name = msg.to.title,
replay =  '??',
lock_link = '??',
lock_id = '??',
lock_tag = '??',
lock_spam = '??',
lock_webpage = '??',
lock_markdown = '??',
flood = '??',
lock_bots = '??',
lock_pin = '??',
welcome = '??',
lock_join = '??',
lock_edit = '??',
lock_mention = '??',
num_msg_max = '5',
},
mutes = {
mute_forward = '??',
mute_audio = '??',
mute_video = '??',
mute_contact = '??',
mute_text = '??',
mute_photo = '??',
mute_gif = '??',
mute_location = '??',
mute_document = '??',
mute_sticker = '??',
mute_voice = '??',
mute_keyboard = '??',
mute_game = '??',
mute_inline = '??',
mute_tgservice = '??',
}
}
save_data(_config.moderation.data, data)
local groups = 'groups'
if not data[tostring(groups)] then
data[tostring(groups)] = {}
save_data(_config.moderation.data, data)
end
data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
save_data(_config.moderation.data, data)
if tonumber(msg.from.id) == tonumber(SUDO)  then
return'??ÊÜã ÊÜİÜÚÜíÜá ÇáÜãÜÌÜãÜæÚÜå ??'
else
tdcli.sendMessage(SUDO, 0, 1, '?? ŞÇã ÇÍÏ ÇáãØæÑíä ÈÊİÚíá ÇáÈæÊ \n?? <code>'..msg.to.title..'?</code>\n?? ÇíÏí ÇáãÌãæÚå : <code>'..msg.to.id..'</code>\n?? ÈæÇÓØÉ : '..msg.from.first_name..'\n?? ãÚÑİå : @'..(msg.from.username or "---"), 1, 'html')
return '??ÊÜã ÊÜİÜÚÜíÜá ÇáÜãÜÌÜãÜæÚÜå ??'

end
end

local function modrem(msg)

-- superuser and admins only (because sudo are always has privilege)
if not is_sudo(msg) then

return '?? _ÃäÜÊ áÜÓÜÊ ÇáÜãÜØÜæÑ _ ??'

end
local data = load_data(_config.moderation.data)
local receiver = msg.to.id
if not data[tostring(msg.to.id)] then
return '?? ÇáãÌãæÚå ÈÇáÊÃßíÏ ?? Êã ÊÚØíáåÇ'
end

data[tostring(msg.to.id)] = nil
save_data(_config.moderation.data, data)
local groups = 'groups'
if not data[tostring(groups)] then
data[tostring(groups)] = nil
save_data(_config.moderation.data, data)
end data[tostring(groups)][tostring(msg.to.id)] = nil
save_data(_config.moderation.data, data)

return '??ÊÜã ÊÜÚÜØÜíÜá ÇáÜãÜÌÜãÜæÚÜå??'

end

local function filter_word(msg, word)

local data = load_data(_config.moderation.data)
if not data[tostring(msg.to.id)]['filterlist'] then
data[tostring(msg.to.id)]['filterlist'] = {}
save_data(_config.moderation.data, data)
end
if data[tostring(msg.to.id)]['filterlist'][(word)] then

return  "?? _ Çáßáãå_ *"..word.."* _åí ÈÇáÊÃßíÏ ãä ŞÇÆãå ÇáãäÚ??_"

end
data[tostring(msg.to.id)]['filterlist'][(word)] = true
save_data(_config.moderation.data, data)

return  "?? _ Çáßáãå_ *"..word.."* _ÊãÊ ÇÖÇİÊåÇ Çáì ŞÇÆãå ÇáãäÚ ??_"

end

local function unfilter_word(msg, word)

local data = load_data(_config.moderation.data)
if not data[tostring(msg.to.id)]['filterlist'] then
data[tostring(msg.to.id)]['filterlist'] = {}
save_data(_config.moderation.data, data)
end
if data[tostring(msg.to.id)]['filterlist'][word] then
data[tostring(msg.to.id)]['filterlist'][(word)] = nil
save_data(_config.moderation.data, data)

return  "?? _ Çáßáãå_ *"..word.."* _Êã ÇáÓãÇÍ ÈåÇ ??_"

else

return  "?? _ Çáßáãå_ *"..word.."* _åí ÈÇáÊÃßíÏ ãÓãæÍ ÈåÇ??_"

end
end

local function modlist(msg)

local data = load_data(_config.moderation.data)
local i = 1
if not data[tostring(msg.chat_id_)] then

return  "?? _åĞå ÇáãÌãæÚå áíÓÊ ãä ÍãÇíÊí ??_"

end
-- determine if table is empty
if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way

return  "?? _áÇ íæÌÏ ÇÏãä İí åĞå ÇáãÌãæÚå ??_"

end

message = '?? *ŞÇÆãå ÇáÇÏãäíå :*\n'

for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
message = message ..i.. '- '..check_markdown(v)..' [' ..k.. '] \n'
i = i + 1
end
return message
end

local function ownerlist(msg)

local data = load_data(_config.moderation.data)
local i = 1
if not data[tostring(msg.to.id)] then
return  "?? _åĞå ÇáãÌãæÚå áíÓÊ ãä ÍãÇíÊí ??_"
end
-- determine if table is empty
if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
return  "?? _ áÇ íæÌÏ åäÇ ãÏíÑ ??_"
end
message = '?? *ŞÇÆãå ÇáãÏÑÇÁ :*\n'
for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
message = message ..i.. '- '..check_markdown(v)..' [' ..k.. '] \n'
i = i + 1
end
return message
end

local function action_by_reply(arg, data)

local cmd = arg.cmd
local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then
if not administration[tostring(data.chat_id_)] then

return tdcli.sendMessage(data.chat_id_, "", 0, "?? _åĞå ÇáãÌãæÚå áíÓÊ ãä ÍãÇíÊí ??_", 0, "md")

end
if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)

local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['whitelist'] then
administration[tostring(arg.chat_id)]['whitelist'] = {}
save_data(_config.moderation.data, administration)
end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..']\n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _ Çäå ÈÇáÊÃßíÏ ãä ÚÖæ ããíÒ ?? _', 0, "md")

end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ ÊãÊ ÊÑŞíÊå áíÕÈÍ Öãä ÚÖæ ããíÒ ??_', 0, "md")

end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['whitelist'] then
administration[tostring(arg.chat_id)]['whitelist'] = {}
save_data(_config.moderation.data, administration)
end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..']\n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _ Çäå ÈÇáÊÃßíÏ áíÓ ãä ÚÖæ ããíÒ ?? _', 0, "md")

end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n??_ ÊãÊ ÊäÒíáå ãä ÚÖæ ããíÒ ??_', 0, "md")
end

tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "setowner" then
local function owner_cb(arg, data)

local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..']\n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n??_ Çäå ÈÇáÊÃßíÏ ãÏíÑ ?? _', 0, "md")
end

administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n??_ ÊãÊ ÊÑŞíÊå áíÕÈÍ ãÏíÑ ??_', 0, "md")

end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "promote" then
local function promote_cb(arg, data)

local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n??_ ÇáÇíÏí ? _*['..data.id_..']*\n??_ Çäå ÈÇáÊÃßíÏ ÇÏãä ??_', 0, "md")
end

administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _ ÊãÊ ÊÑŞíÊå áíÕÈÍ ÇÏãä ??_', 0, "md")

end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "remowner" then
local function rem_owner_cb(arg, data)

local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _Çäå ÈÇáÊÃßíÏ áíÓ ãÏíÑ ??_', 0, "md")
end

administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _Êã ÊäÒíáå ãä ÇáÇÏÇÑå ??_', 0, "md")

end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "demote" then
local function demote_cb(arg, data)
local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _Çäå ÈÇáÊÃßíÏ áíÓ ÇÏãä ??_', 0, "md")

end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ?_ *['..data.id_..']*\n?? _Êã ÊäÒíáå ãä ÇáÇÏãäíå ??_', 0, "md")

end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "ÇíÏí" then
local function id_cb(arg, data)
return tdcli.sendMessage(arg.chat_id, "", 0, "`"..data.id_.."`", 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
else

return tdcli.sendMessage(data.chat_id_, "", 0, "*?? ÇáÚÖæ ? ÛíÑ ãæÌæÏ ??*", 0, "md")

end
end

local function action_by_username(arg, data)

local cmd = arg.cmd
local administration = load_data(_config.moderation.data)
if not administration[tostring(arg.chat_id)] then

return tdcli.sendMessage(data.chat_id_, "", 0, "?? _åĞå ÇáãÌãæÚå áíÓÊ ãä ÍãÇíÊí ??", 0, "md")

end
if not arg.username then return false end
if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..data.type_.user_.username_
else
user_name = data.title_
end
if cmd == "setwhitelist" then
if not administration[tostring(arg.chat_id)]['whitelist'] then
administration[tostring(arg.chat_id)]['whitelist'] = {}
save_data(_config.moderation.data, administration)
end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..']\n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n??_ Çäå ÈÇáÊÃßíÏ ãä ÚÖæ ããíÒ ?? _', 0, "md")
end

administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ ÊãÊ ÊÑŞíÊå áíÕÈÍ Öãä ÚÖæ ããíÒ ??_', 0, "md")

end
if cmd == "remwhitelist" then
if not administration[tostring(arg.chat_id)]['whitelist'] then
administration[tostring(arg.chat_id)]['whitelist'] = {}
save_data(_config.moderation.data, administration)
end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..']\n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _Çäå ÈÇáÊÃßíÏ áíÓ ãä ÚÖæ ããíÒ ?? _', 0, "md")

end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n??_ ÊãÊ ÊäÒíáå ãä ÚÖæ ããíÒ ??_', 0, "md")

end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..']\n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _ Çäå ÈÇáÊÃßíÏ ãÏíÑ ?? _', 0, "md")

end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ ÊãÊ ÊÑŞíÊå áíÕÈÍ ãÏíÑ ??_', 0, "md")

end
if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _ Çäå ÈÇáÊÃßíÏ ÇÏãä ??_', 0, "md")

end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _ ÊãÊ ÊÑŞíÊå áíÕÈÍ ÇÏãä ??_', 0, "md")

end
if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _Çäå ÈÇáÊÃßíÏ áíÓ ãÏíÑ ??_', 0, "md")

end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _Êã ÊäÒíáå ãä ÇáÇÏÇÑå ??_', 0, "md")

end
if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _Çäå ÈÇáÊÃßíÏ áíÓ ÇÏãä ??_', 0, "md")

end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ?_ *['..data.id_..']*\n?? _Êã ÊäÒíáå ãä ÇáÇÏãäíå ??_', 0, "md")

end
if cmd == "ÇíÏí" then
return tdcli.sendMessage(arg.chat_id, "", 0, "`"..data.id_.."`", 0, "md")
end

else

return tdcli.sendMessage(arg.chat_id, "", 0, "*?? ÇáÚÖæ ? ÛíÑ ãæÌæÏ ??*", 0, "md")

end
end

local function action_by_id(arg, data)

local cmd = arg.cmd
local administration = load_data(_config.moderation.data)
if not administration[tostring(arg.chat_id)] then

return tdcli.sendMessage(data.chat_id_, "", 0, "?? _åĞå ÇáãÌãæÚå áíÓÊ ãä ÍãÇíÊí ??", 0, "md")

end
if not tonumber(arg.user_id) then return false end
if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
if cmd == "setwhitelist" then
if not administration[tostring(arg.chat_id)]['whitelist'] then
administration[tostring(arg.chat_id)]['whitelist'] = {}
save_data(_config.moderation.data, administration)
end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..']\n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n??_ Çäå ÈÇáÊÃßíÏ ãä ÚÖæ ããíÒ ?? _', 0, "md")

end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ ÊãÊ ÊÑŞíÊå áíÕÈÍ Öãä ÚÖæ ããíÒ ??_', 0, "md")

end
if cmd == "remwhitelist" then
if not administration[tostring(arg.chat_id)]['whitelist'] then
administration[tostring(arg.chat_id)]['whitelist'] = {}
save_data(_config.moderation.data, administration)
end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..']\n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n??_ Çäå ÈÇáÊÃßíÏ áíÓ ãä ÚÖæ ããíÒ ?? _', 0, "md")

end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ ÊãÊ ÊäÒíáå ãä ÚÖæ ããíÒ ??_', 0, "md")
end

if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..']\n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _ Çäå ÈÇáÊÃßíÏ ãÏíÑ ?? _', 0, "md")

end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ ÊãÊ ÊÑŞíÊå áíÕÈÍ ãÏíÑ ??_', 0, "md")

end

if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _ Çäå ÈÇáÊÃßíÏ ÇÏãä ??_', 0, "md")

end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ? _*['..data.id_..']*\n?? _ ÊãÊ ÊÑŞíÊå áíÕÈÍ ÇÏãä ??_', 0, "md")

end
if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _Çäå ÈÇáÊÃßíÏ áíÓ ãÏíÑ ??_', 0, "md")

end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _Êã ÊäÒíáå ãä ÇáÇÏÇÑå ??_', 0, "md")

end
if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n??_ ÇáÇíÏí ? _*['..data.id_..']*\n?? _Çäå ÈÇáÊÃßíÏ áíÓ ÇÏãä ??_', 0, "md")
end

administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ ÇáÇíÏí ?_ *['..data.id_..']*\n?? _Êã ÊäÒíáå ãä ÇáÇÏãäíå ??_', 0, "md")

end
if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
username = '*áÇíæÌÏ*'
end

return tdcli.sendMessage(arg.chat_id, 0, 1, '?? _ ÇáÇíÏí ?_ *[ '..data.id_..' ]* \n?? _ÇáãÚÑİ_ : '..username..'\n?? _ÇáÇÓã_ : '..data.first_name_, 1)
end
else

return tdcli.sendMessage(arg.chat_id, "", 0, "_ÇáÚÖæ ? áÇ íæÌÏ_", 0, "md")

end
else

return tdcli.sendMessage(arg.chat_id, "", 0, "_ÇáÚÖæ ? áÇ íæÌÏ_", 0, "md")

end
end

---------------Lock brod-------------------
local function lock_brod(msg, data, target)
if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ  _ ??"
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local lock_brod = data[tostring(target)]["settings"]["lock_brod"] 
if lock_brod == "no" then
return '?? _ÇĞÇÚå ÇáãØæÑíä ÈÇáÊÇßíÏ Êã ÊÚØíáå_\n??_ ÇáÑÊÈå : '..ioer..'_'
else
data[tostring(target)]["settings"]["lock_brod"] = "no"
save_data(_config.moderation.data, data) 
return '?? _Êã ÊÚØíá ÇĞÇÚå ÇáãØæÑíä_\n??_ ÇáÑÊÈå : '..ioer..'_'
end
end

local function unlock_brod(msg, data, target)
if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local lock_brod = data[tostring(target)]["settings"]["lock_brod"]
if lock_brod == "yes" then
return '?? _ÇĞÇÚå ÇáãØæÑíä ÈÇáÊÇßíÏ Êã ÊİÚíáå_\n??_ ÇáÑÊÈå : '..ioer..'_'
else 
data[tostring(target)]["settings"]["lock_brod"] = "yes"
save_data(_config.moderation.data, data) 
return '?? _Êã ÊİÚíá ÇĞÇÚå ÇáãØæÑíä_\n??_ ÇáÑÊÈå : '..ioer..'_'
end
end


---------------Lock replay-------------------
local function lock_replay(msg, data, target)
if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local replay = data[tostring(target)]["settings"]["replay"] 
if replay == "??" then
return '?? _ÇáÑÏæÏ ÈÇáÊÇßíÏ Êã ÊÚØíáå_\n??_ ÇáÑÊÈå : '..ioer..'_'
else
data[tostring(target)]["settings"]["replay"] = "??"
save_data(_config.moderation.data, data) 
return '?? _Êã ÊÚØíá ÇáÑÏæÏ_\n??_ ÇáÑÊÈå : '..ioer..'_'
end
end

local function unlock_replay(msg, data, target)
if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end 

-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local replay = data[tostring(target)]["settings"]["replay"]
if replay == "??" then
return '?? _ÇáÑÏæÏ ÈÇáÊÇßíÏ Êã ÊİÚíáå_\n??_ ÇáÑÊÈå : '..ioer..'_'
else 
data[tostring(target)]["settings"]["replay"] = "??"
save_data(_config.moderation.data, data) 
return '?? _Êã ÊİÚíá ÇáÑÏæÏ_\n??_ ÇáÑÊÈå : '..ioer..'_'
end
end

---------------Lock Link-------------------
local function lock_link(msg, data, target)

if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "??" then
return '?? _ÇáÑæÇÈØ ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'
else
data[tostring(target)]["settings"]["lock_link"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÑæÇÈØ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_link(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_link = data[tostring(target)]["settings"]["lock_link"]
if lock_link == "??" then

return '?? _ÇáÑæÇÈØ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["settings"]["lock_link"] = "??" save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÑæÇÈØ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "??" then

return '?? _ÇáÊÇß(#) ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["lock_tag"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÊÇß(#)_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_tag(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
if lock_tag == "??" then

return '?? _ÇáÊÇß(#) ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["settings"]["lock_tag"] = "??" save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÊÇß(#)_\n??_ ÇáÑÊÈå : '..ioer..'_'
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "??" then

return '?? _ÇáÊĞßíÑ ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["lock_mention"] = "??"
save_data(_config.moderation.data, data)

return '?? _Êã Şİá ÇáÊĞßíÑ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_mention(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
if lock_mention == "??" then

return '?? _ÇáÊĞßíÑ ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["settings"]["lock_mention"] = "??" save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÊĞßíÑ _\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end


---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "??" then

return '?? _ÇáÊÚÏíá ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["lock_edit"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÊÚÏíá_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_edit(msg, data, target)
if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
if lock_edit == "??" then
return '?? _ÇáÊÚÏíá ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'
else 
data[tostring(target)]["settings"]["lock_edit"] = "??" save_data(_config.moderation.data, data) 
return '?? _Êã İÊÍ ÇáÊÚÏíá_ ??'
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "??" then

return '?? _ÇáßáÇíÔ ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["lock_spam"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáßáÇíÔ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_spam(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
if lock_spam == "??" then

return '?? _ÇáßáÇíÔ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["settings"]["lock_spam"] = "??" 
save_data(_config.moderation.data, data)

return '?? _Êã İÊÍ ÇáßáÇíÔ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "??" then

return '?? _ÇáÊßÑÇÑ ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["flood"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÊßÑÇÑ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_flood(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_flood = data[tostring(target)]["settings"]["flood"]
if lock_flood == "??" then

return '?? _ÇáÊßÑÇÑ ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["settings"]["flood"] = "??" save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÊßÑÇÑ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "??" then

return '?? _ÇáÈæÊÇÊ ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["lock_bots"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÈæÊÇÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_bots(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
if lock_bots == "??" then

return '?? _ÇáÈæÊÇÊ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["settings"]["lock_bots"] = "??" save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÈæÊÇÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "??" then

return '?? _ÇáÇÖÇİå ÈÇáÊÇßíÏ Êã ŞİáåÇ  Ï_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["lock_join"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÇÖÇİå_\n??_ ÇáÑÊÈå : '..ioer..'_'
end
end

local function unlock_join(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_join = data[tostring(target)]["settings"]["lock_join"]
if lock_join == "??" then

return '?? _ÇáÇÖÇİå ÈÇáÊÇßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["settings"]["lock_join"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÇÖÇİå_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "??" then

return '?? _ÇáãÇÑßÏæÇä ÈÇáÊÇßíÏ Êã Şİáå _\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["lock_markdown"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáãÇÑßÏæÇä_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_markdown(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?


local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
if lock_markdown == "??" then

return '?? _ÇáãÇÑßÏæÇä ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["settings"]["lock_markdown"] = "??" save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáãÇÑßÏæÇä_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "??" then

return '?? _ÇáæíÈ ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["lock_webpage"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáæíÈ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_webpage(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
if lock_webpage == "??" then

return '?? _ÇáæíÈ ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["settings"]["lock_webpage"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáæíÈ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "??" then

return '?? _ÇáÊËÈíÊ ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["settings"]["lock_pin"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÊËÈíÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unlock_pin(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
if lock_pin == "??" then

return '?? _ÇáÊËÈíÊ ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'


else 
data[tostring(target)]["settings"]["lock_pin"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÊËÈíÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
--------Mutes---------

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == "??" then

return '?? _ÇáãÊÍÑßå ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_gif"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáãÊÍÑßå_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end

local function unmute_gif(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
if mute_gif == "??" then
return '?? _ÇáãÊÍÑßå ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else 
data[tostring(target)]["mutes"]["mute_gif"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáãÊÍÑßå_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == "??" then

return '?? _ÇáÇáÚÇÈ ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_game"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÇáÚÇÈ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unmute_game(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_game = data[tostring(target)]["mutes"]["mute_game"]
if mute_game == "??" then

return '?? _ÇáÃáÚÇÈ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else 
data[tostring(target)]["mutes"]["mute_game"] = "??"
save_data(_config.moderation.data, data)

return '?? _Êã İÊÍ ÇáÃáÚÇÈ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == "??" then

return '?? _ÇáÇäáÇíä ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_inline"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÇäáÇíä_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end

local function unmute_inline(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
if mute_inline == "??" then

return '?? _ÇáÇäáÇíä ÈÇáÊÃßíÏ Êã İÊÍå\n??_ ÇáÑÊÈå : '..ioer..'_'


else 
data[tostring(target)]["mutes"]["mute_inline"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÇäáÇíä\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 

if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == "??" then
return '?? _ÇáÏÑÔå ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_text"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÏÑÏÔå_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unmute_text(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_text = data[tostring(target)]["mutes"]["mute_text"]
if mute_text == "??" then

return '?? _ÇáÏÑÏÔå ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else 
data[tostring(target)]["mutes"]["mute_text"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÏÑÏÔå_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == "??" then

return '?? _ÇáÕæÑ ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_photo"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÕæÑ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end

local function unmute_photo(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
if mute_photo == "??" then

return '?? _ÇáÕæÑ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else 
data[tostring(target)]["mutes"]["mute_photo"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáÕæÑ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == "??" then

return '?? _ÇáİíÏíæ ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_video"] = "??" 
save_data(_config.moderation.data, data)

return '?? _Êã Şİá ÇáİíÏíæ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end

local function unmute_video(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_video = data[tostring(target)]["mutes"]["mute_video"]
if mute_video == "??" then

return '?? _ÇáİíÏíæåÇÊ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["mutes"]["mute_video"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáİíÏíæ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == "??" then

return '?? _ÇáÈÕãÇÊ ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["mutes"]["mute_audio"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÈÕãÇÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unmute_audio(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
if mute_audio == "??" then

return '?? _ÇáÈÕãÇÊ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["mutes"]["mute_audio"] = "??"
save_data(_config.moderation.data, data)

return '?? _Êã İÊÍ ÇáÈÕãÇÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == "??" then

return '?? _ÇáÕæÊ ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["mutes"]["mute_voice"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÕæÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'
end

end

local function unmute_voice(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
if mute_voice == "??" then

return '?? _ÇáÕæÊ ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["mutes"]["mute_voice"] = "??"
save_data(_config.moderation.data, data)

return '?? _Êã İÊÍ ÇáÕæÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == "??" then

return '?? _ÇáãáÕŞÇÊ ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_sticker"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáãáÕŞÇÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end

local function unmute_sticker(msg, data, target)

if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
if mute_sticker == "??" then

return '?? _ÇáãáÕŞÇÊ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else 
data[tostring(target)]["mutes"]["mute_sticker"] = "??"
save_data(_config.moderation.data, data)

return '?? _Êã İÊÍ ÇáãáÕŞÇÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == "??" then

return '?? _ÌåÇÊ ÇáÇÊÕÇá ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else
data[tostring(target)]["mutes"]["mute_contact"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÌåÇÊ ÇáÇÊÕÇá_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end

local function unmute_contact(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
if mute_contact == "??" then

return '?? _ÌåÇÊ ÇáÇÊÕÇá ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else 
data[tostring(target)]["mutes"]["mute_contact"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÌåÇÊ ÇáÇÊÕÇá_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == "??" then

return '?? _ÇáÊæÌíå ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_forward"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÊæÌíå_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unmute_forward(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
if mute_forward == "??" then
return '?? _ÇáÊæÌíå ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["mutes"]["mute_forward"] = "??"
save_data(_config.moderation.data, data)

return '?? _Êã İÊÍ ÇáÊæÌíå_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == "??" then

return '?? _ÇáãæŞÚ ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_location"] = "??" 
save_data(_config.moderation.data, data)

return '?? _Êã Şİá ÇáãæŞÚ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end

local function unmute_location(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end 
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_location = data[tostring(target)]["mutes"]["mute_location"]
if mute_location == "??" then

return '?? _ÇáãæŞÚ ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["mutes"]["mute_location"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáãæŞÚ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == "??" then

return '?? _ÇáãáİÇÊ ÈÇáÊÃßíÏ Êã ŞİáåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_document"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáãáİÇÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unmute_document(msg, data, target)

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end

-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_document = data[tostring(target)]["mutes"]["mute_document"]
if mute_document == "??" then

return '?? _ÇáãáİÇÊ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["mutes"]["mute_document"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáãáİÇÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'


end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == "??" then

return '?? _ÇáÇÔÚÇÑÇÊ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_tgservice"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáÇÔÚÇÑÇÊ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unmute_tgservice(msg, data, target)

if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
if mute_tgservice == "??" then

return '?? _ÇáÇÔÚÇÑÇÊ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["mutes"]["mute_tgservice"] = "??"
save_data(_config.moderation.data, data) 

return '?? _ÇáÇÔÚÇÑÇÊ ÈÇáÊÃßíÏ Êã İÊÍåÇ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard == "??" then

return '?? _ÇáßíÈæÑÏ ÈÇáÊÃßíÏ Êã Şİáå_\n??_ ÇáÑÊÈå : '..ioer..'_'


else
data[tostring(target)]["mutes"]["mute_keyboard"] = "??" 
save_data(_config.moderation.data, data) 

return '?? _Êã Şİá ÇáßíÈæÑÏ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end

local function unmute_keyboard(msg, data, target)

if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?
if is_sudo(msg) then
ioer = 'ÇáãØæÑ'
elseif is_owner(msg) then
ioer = 'ÇáãÏíÑ'
elseif is_mod(msg) then
ioer = 'ÇÏãä'
end
-- ÍÕÇäå ÇáÊÍŞŞ ãä ÇáÚÖæ ?

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"]
if mute_keyboard == "??" then

return '?? _ÇáßíÈæÑÏ ÈÇáÊÃßíÏ Êã İÊÍå_\n??_ ÇáÑÊÈå : '..ioer..'_'

else 
data[tostring(target)]["mutes"]["mute_keyboard"] = "??"
save_data(_config.moderation.data, data) 

return '?? _Êã İÊÍ ÇáßíÈæÑÏ_\n??_ ÇáÑÊÈå : '..ioer..'_'

end
end
----------MuteList---------
local function mutes(msg, target) 	

if not is_mod(msg) then
return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"
end

local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)]["mutes"] then		

if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "??"		
end
end

local mutes = data[tostring(target)]["mutes"]
text = "?????` ÇÚÏÇÏÇÊ ÇáæÓÇÆØ:`"
.."\n\n?? Şİá ÇáãÊÍÑßå : "..mutes.mute_gif
.."\n?? Şİá ÇáÏÑÏÔå : "..mutes.mute_text
.."\n?? Şİá ÇáÇäáÇíä : "..mutes.mute_inline
.."\n?? Şİá ÇáÇáÚÇÈ : "..mutes.mute_game
.."\n?? Şİá ÇáÕæÑ : "..mutes.mute_photo
.."\n?? Şİá ÇáİíÏíæ : "..mutes.mute_video
.."\n?? Şİá ÇáÈÕãÇÊ : "..mutes.mute_audio
.."\n?? Şİá ÇáÕæÊ : "..mutes.mute_voice
.."\n?? Şİá ÇáãáÕŞÇÊ : "..mutes.mute_sticker
.."\n?? Şİá ÇáÌåÇÊ : "..mutes.mute_contact
.."\n?? Şİá ÇáÊæÌíå : "..mutes.mute_forward
.."\n?? Şİá ÇáãæŞÚ : "..mutes.mute_location
.."\n?? Şİá ÇáãáİÇÊ : "..mutes.mute_document
.."\n?? Şİá ÇáÇÔÚÇÑÇÊ : "..mutes.mute_tgservice
.."\n?? Şİá ÇáßíÈæÑÏ : "..mutes.mute_keyboard
.."\n?? ãØæÑ ÇáÜÈÜæÊ : "..sudouser.."\n??????"

return  tdcli.sendMessage(msg.to.id, msg.id, 0,text , 0, "md")
end

function group_settings(msg, target) 	

if not is_mod(msg) then

return "?? _åĞÇ ÇáÇãÑ íÎÕ ÇáÇÏãäíå İŞØ _ ??"

end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	

if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end

if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "??"		
end
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_pin"] then			
data[tostring(target)]["settings"]["lock_pin"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_join"] then			
data[tostring(target)]["settings"]["lock_join"] = "??"		
end
if not data[tostring(target)]["settings"]["replay"] then			
data[tostring(target)]["settings"]["replay"] = "??"		
end
if not data[tostring(target)]["settings"]["lock_woring"] then			
data[tostring(target)]["settings"]["lock_woring"] = "??"		
end
end

if data[tostring(target)]["mutes"] then		

if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "??"		
end
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "??"		
end
end


local settings = data[tostring(target)]["settings"] 
local mutes = data[tostring(target)]["mutes"]


list_settings = "?????` ÇÚÏÇÏÇÊ ÇáãÌãæÚå :` "
.."\n?? Şİá ÇáÊÚÏíá : "..settings.lock_edit
.."\n?? Şİá ÇáÑæÇÈØ : "..settings.lock_link
.."\n?? Şİá ÇáÇÖÇİå : "..settings.lock_join
.."\n?? Şİá ÇáÊÇß : "..settings.lock_tag
.."\n\n?? Şİá ÇáÊßÑÇÑ : "..settings.flood
-- .."\n?? Şİá ÇáßáÇíÔ : "..settings.lock_spam
.."\n?? Şİá ÇáæíÈ : "..settings.lock_webpage
-- .."\n?? Şİá ÇáãÇÑßÏæÇä : "..settings.lock_markdown
.."\n?? Şİá ÇáÊËÈíÊ : "..settings.lock_pin
.."\n?? Şİá ÇáÈæÊÇÊ : "..settings.lock_bots
.."\n?? ÚÏÏ ÇáÊßÑÇÑ : "..settings.num_msg_max


list_mutes = "??` ÇÚÏÇÏÇÊ ÇáæÓÇÆØ:`"
.."\n?? Şİá ÇáãÊÍÑßå : "..mutes.mute_gif
--.."\n?? Şİá ÇáÏÑÏÔå : "..mutes.mute_text
.."\n?? Şİá ÇáÇäáÇíä : "..mutes.mute_inline
--.."\n?? Şİá ÇáÇáÚÇÈ : "..mutes.mute_game
.."\n?? Şİá ÇáÕæÑ : "..mutes.mute_photo
.."\n?? Şİá ÇáİíÏíæ : "..mutes.mute_video
.."\n?? Şİá ÇáÈÕãÇÊ : "..mutes.mute_audio
.."\n?? Şİá ÇáÕæÊ : "..mutes.mute_voice
.."\n?? Şİá ÇáãáÕŞÇÊ : "..mutes.mute_sticker
.."\n?? Şİá ÇáÌåÇÊ : "..mutes.mute_contact
.."\n?? Şİá ÇáÊæÌíå : "..mutes.mute_forward
-- .."\n?? Şİá ÇáãæŞÚ : "..mutes.mute_location
-- .."\n?? Şİá ÇáãáİÇÊ : "..mutes.mute_document
.."\n?? Şİá ÇáÇÔÚÇÑÇÊ : "..mutes.mute_tgservice
-- .."\n?? Şİá ÇáßíÈæÑÏ : "..mutes.mute_keyboard

.."\n\n??` ÇÚÏÇÏÇÊ ÇÎÑì :` "
.."\n?? ÊİÚíá ÇáÊÑÍíÈ : "..settings.welcome
.."\n?? ÊİÚíá ÇáÑÏæÏ : "..settings.replay
.."\n?? ÊİÚíá ÇáÊÍĞíÑ : "..settings.lock_woring
.."\n?? ÊİÚíá ÇáÇíÏí ? : "..settings.lock_id 

.."\n?? ãØæÑ ÇáÜÈÜæÊ : "..sudouser.."\n??????"

return  tdcli.sendMessage(msg.to.id, 1, 0,list_settings.."\n\n"..list_mutes , 0, "md")
end

local function moody(msg, matches)

local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if matches[1] == "ÊİÚíá" and not matches[2] then
return modadd(msg)
end
if matches[1] == "ÊÚØíá" and not matches[2] then
return modrem(msg)
end
if not data[tostring(msg.to.id)] then return end
if matches[1] == "ÇíÏí" then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
if data.photos_[0] then
local rank
if is_sudo(msg) then
rank = 'ÇáãØæÑ ãÇáÊí ??'
elseif is_owner(msg) then
rank = 'ãÏíÑ İí ÇáÈæÊ ??'
elseif is_sudo(msg) then
rank = 'ÇÏÇÑí İí ÇáÈæÊ ??'
elseif is_mod(msg) then
rank = 'ÇÏãä İí ÇáÈæÊ ??'
else
rank = 'ãÌÑÏ ÚÖæ ??'
end
if msg.from.username then
userxn = "@"..(msg.from.username or "---")
else
userxn = "áÇ íÊæİÑ"
end
local msgs = tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0)

tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'?? ãÚÑİß : '..userxn..'\n?? ÇíÏíß : '..msg.from.id..'\n?? ÑÊÈÊß : '..rank..'\n??? ÚÏÏ ÑÓÇÆáß : ['..msgs..'] ÑÓÇáÉ \n',dl_cb,nil)
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, "??áÇ íæÌÏ ÕæÑå İí ÈÑæİÇíáß ...!\n\n *?? ÇíÏí ÇáãÌãæÚå :* `"..msg.to.id.."`\n*?? ÇíÏíß :* `"..msg.from.id.."`", 1, 'md')
end
end
local lock_id = data[tostring(msg.to.id)]["settings"]["lock_id"] 
if lock_id == "??" then
tdcli_function ({
ID = "GetUserProfilePhotos",
user_id_ = msg.from.id,
offset_ = 0,
limit_ = 1
}, getpro, nil)
end
end
if msg.reply_id and not matches[2] and is_mod(msg) then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="ÇíÏí"})
end
if matches[2] and is_mod(msg) then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ÇíÏí"})
end
end
if matches[1] == "ÊËÈíÊ" and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
if lock_pin == '??' then
if is_owner(msg) then
data[tostring(chat)]['pin'] = msg.reply_id
save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)

return "?? _ãÑÍÈÂ ÚÒíÒí_\n?? _ Êã ÊËÈíÊ ÇáÑÓÇáå_??"

elseif not is_owner(msg) then
return
end
elseif lock_pin == '??' then
data[tostring(chat)]['pin'] = msg.reply_id
save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)

return "?? _ãÑÍÈÂ ÚÒíÒí_\n?? _ Êã ÊËÈíÊ ÇáÑÓÇáå_ ??"

end
end
if matches[1] == "ÇáÛÇÁ ÇáÊËÈíÊ" and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
if lock_pin == '??' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
return "?? _ãÑÍÈÂ ÚÒíÒí_\n?? _ Êã ÇáÛÇÁ ÊËÈíÊ ÇáÑÓÇáå_ ??"

elseif not is_owner(msg) then
return 
end
elseif lock_pin == '??' then
tdcli.unpinChannelMessage(msg.to.id)

return "?? _ãÑÍÈÂ ÚÒíÒí_\n?? _ Êã ÇáÛÇÁ ÊËÈíÊ ÇáÑÓÇáå_ ??"

end
end

if matches[1] == "ÑİÚ ÚÖæ ããíÒ" and is_mod(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setwhitelist"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setwhitelist"})
end
end
if matches[1] == "ÊäÒíá ÚÖæ ããíÒ" and is_mod(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remwhitelist"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remwhitelist"})
end
end

if matches[1] == "ÑİÚ ÇáãÏíÑ" and is_sudo(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
end
end
if matches[1] == "ÊäÒíá ÇáãÏíÑ" and is_sudo(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
end
end
if matches[1] == "ÑİÚ ÇÏãä" and is_owner(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
end
end
if matches[1] == "ÊäÒíá ÇÏãä" and is_owner(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "GetUser",
user_id_ = matches[2],
}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
end
end

if matches[1] == "Şİá" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "ÇáÑæÇÈØ" then
return lock_link(msg, data, target)
end
if matches[2] == "ÇáÊÇß" then
return lock_tag(msg, data, target)
end

if matches[2] == "ÇáÊÚÏíá" then
return lock_edit(msg, data, target)
end
if matches[2] == "ÇáßáÇíÔ" then
return lock_spam(msg, data, target)
end
if matches[2] == "ÇáÊßÑÇÑ" then
return lock_flood(msg, data, target)
end
if matches[2] == "ÇáÈæÊÇÊ" then
return lock_bots(msg, data, target)
end
if matches[2] == "ÇáãÇÑßÏæÇä" then
return lock_markdown(msg, data, target)
end
if matches[2] == "ÇáæíÈ" then
return lock_webpage(msg, data, target)
end
if matches[2] == "ÇáËÈíÊ" and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "ÇáÇÖÇİå" then
return lock_join(msg, data, target)
end
end
if matches[1] == "İÊÍ" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "ÇáÑæÇÈØ" then
return unlock_link(msg, data, target)
end
if matches[2] == "ÇáÊÇß" then
return unlock_tag(msg, data, target)
end
if matches[2] == "ÇáÊÚÏíá" then
return unlock_edit(msg, data, target)
end
if matches[2] == "ÇáßáÇíÔ" then
return unlock_spam(msg, data, target)
end
if matches[2] == "ÇáÊßÑÇÑ" then
return unlock_flood(msg, data, target)
end
if matches[2] == "ÇáÈæÊÇÊ" then
return unlock_bots(msg, data, target)
end
if matches[2] == "ÇáãÇÑßæÇä" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "ÇáæíÈ" then
return unlock_webpage(msg, data, target)
end
if matches[2] == "ÇáÊËÈíÊ" and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "ÇáÇÖÇİå" then
return unlock_join(msg, data, target)
end
end

if matches[1] == "Şİá" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "Çáßá" then
local close_all ={
mute_gif(msg, data, target),
mute_photo(msg ,data, target),
mute_audio(msg ,data, target),
mute_voice(msg ,data, target),
mute_sticker(msg ,data, target),
mute_forward(msg ,data, target),
mute_contact(msg ,data, target),
mute_location(msg ,data, target),
mute_document(msg ,data, target),
mute_inline(msg ,data, target),
lock_link(msg, data, target),
lock_tag(msg, data, target),
lock_mention(msg, data, target),
lock_edit(msg, data, target),
lock_spam(msg, data, target),
lock_bots(msg, data, target),
lock_webpage(msg, data, target),
mute_video(msg ,data, target),
}
local text =  '?? _Êã Şİá Çáßá _ ??'
tdcli.sendMessage(msg.to.id, msg.id, 1, text, 0, "md")    
return close_all
end
if matches[2] == "ÇáãÊÍÑßå" then
return mute_gif(msg, data, target)
end
if matches[2] == "ÇáÏÑÏÔå" then
return mute_text(msg ,data, target)
end
if matches[2] == "ÇáÕæÑ" then
return mute_photo(msg ,data, target)
end
if matches[2] == "ÇáİíÏíæ" then
return mute_video(msg ,data, target)
end
if matches[2] == "ÇáÈÕãÇÊ" then
return mute_audio(msg ,data, target)
end
if matches[2] == "ÇáÕæÊ" then
return mute_voice(msg ,data, target)
end
if matches[2] == "ÇáãáÕŞÇÊ" then
return mute_sticker(msg ,data, target)
end
if matches[2] == "ÇáÌåÇÊ" then
return mute_contact(msg ,data, target)
end
if matches[2] == "ÇáÊæÌíå" then
return mute_forward(msg ,data, target)
end
if matches[2] == "ÇáãæŞÚ" then
return mute_location(msg ,data, target)
end
if matches[2] == "ÇáãáİÇÊ" then
return mute_document(msg ,data, target)
end
if matches[2] == "ÇáÇÔÚÇÑÇÊ" then
return mute_tgservice(msg ,data, target)
end
if matches[2] == "ÇáÇäáÇíä" then
return mute_inline(msg ,data, target)
end
if matches[2] == "ÇáÇáÚÇÈ" then
return mute_game(msg ,data, target)
end
if matches[2] == "ÇáßíÈæÑÏ" then
return mute_keyboard(msg ,data, target)
end
end
if matches[1] == "İÊÍ" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "Çáßá" then
local open_all ={
unmute_gif(msg, data, target),
unmute_photo(msg ,data, target),
unmute_audio(msg ,data, target),
unmute_voice(msg ,data, target),
unmute_sticker(msg ,data, target),
unmute_forward(msg ,data, target),
unmute_contact(msg ,data, target),
unmute_location(msg ,data, target),
unmute_document(msg ,data, target),
unlock_link(msg, data, target),
unlock_tag(msg, data, target),
unlock_mention(msg, data, target),
unlock_edit(msg, data, target),
unlock_spam(msg, data, target),
unlock_bots(msg, data, target),
unlock_webpage(msg, data, target),
unmute_video(msg ,data, target),
unmute_inline(msg ,data, target)
}

local text =  '?? _Êã İÊÍ Çáßá _ ??' 
tdcli.sendMessage(msg.to.id, msg.id, 1, text, 0, "md")    
return open_all
end
if matches[2] == "ÇáãÊÍÑßå" then
return unmute_gif(msg, data, target)
end
if matches[2] == "ÇáÏÑÏÔå" then
return unmute_text(msg, data, target)
end
if matches[2] == "ÇáÕæÑ" then
return unmute_photo(msg ,data, target)
end
if matches[2] == "ÇáİíÏíæ" then
return unmute_video(msg ,data, target)
end
if matches[2] == "ÇáÈÕãÇÊ" then
return unmute_audio(msg ,data, target)
end
if matches[2] == "ÇáÕæÊ" then
return unmute_voice(msg ,data, target)
end
if matches[2] == "ÇáãáÕŞÇÊ" then
return unmute_sticker(msg ,data, target)
end
if matches[2] == "ÇáÌåÇÊ" then
return unmute_contact(msg ,data, target)
end
if matches[2] == "ÇáÊæÌíå" then
return unmute_forward(msg ,data, target)
end
if matches[2] == "ÇáãæŞÚ" then
return unmute_location(msg ,data, target)
end
if matches[2] == "ÇáãáİÇÊ" then
return unmute_document(msg ,data, target)
end
if matches[2] == "ÇáÇÔÚÇÑÇÊ" then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == "ÇáÇäáÇíä" then
return unmute_inline(msg ,data, target)
end
if matches[2] == "ÇáÇáÚÇÈ" then
return unmute_game(msg ,data, target)
end
if matches[2] == "ÇáßíÈæÑÏ" then
return unmute_keyboard(msg ,data, target)
end
end
if matches[1] == "ÇáãÌãæÚå" and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)

ginfo = "?? _ãÚáæãÇÊ ÇáãÌãæÚå :_\n?? _ÚÏÏ ÇáÇÏãäíå _*["..data.administrator_count_.."]*\n?? _ÚÏÏ ÇáÇÚÖÇÁ _*["..data.member_count_.."]*\n?? _ÚÏÏ ÇáãØÑæÏíä _*["..data.kicked_count_.."]*\n?? _ÇíÏí ÇáãÌãæÚå _*["..data.channel_.id_.."]*"

tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if matches[1] == 'ÊÛíÑ ÇáÑÇÈØ' and is_mod(msg) then
local function callback_link (arg, data)

local administration = load_data(_config.moderation.data) 
if not data.invite_link_ then
administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(msg.to.id, msg.id, 1, "*ÇáÈæÊ áíÓ ãäÔÆ ÇáãÌãæÚÉ Şã ÈÃÖÇİÉ ÇáÑÇÈØ ÈÃÑÓÇá* [ ÖÚ ÑÇÈØ ]", 1, 'md')

else
administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
save_data(_config.moderation.data, administration)

return tdcli.sendMessage(msg.to.id, msg.id, 1, "*?? _ÔßÑÃ áß ??_\n?? _Êã ÍİÙ ÇáÑÇÈØ ÈäÌÇÍ _?? *", 1, 'md')

end
end
tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
end
if matches[1] == "ÖÚ ÑÇÈØ" and is_owner(msg) then
data[tostring(chat)]['settings']['linkgp'] = 'waiting'
save_data(_config.moderation.data, data)

return "?? _ãÑÍÈÂ ÚÒíÒí_\n?? _ÑÌÇÆÇ ÇÑÓá ÇáÑÇÈØ ÇáÂä _??"

end

if msg.text then
local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
data[tostring(chat)]['settings']['linkgp'] = msg.text
save_data(_config.moderation.data, data)

return "?? _ÔßÑÃ áß ??_\n?? _Êã ÍİÙ ÇáÑÇÈØ ÈäÌÇÍ _??"

end
end

if matches[1] == "ÇáÑÇÈØ" and is_mod(msg) then
local linkgp = data[tostring(chat)]['settings']['linkgp']
if not linkgp then
return "?? _Çæå ?? áÇ íæÌÏ åäÇ ÑÇÈØ_\n?? _ÑÌÇÆÇ ÇßÊÈ [ÖÚ ÑÇÈØ]_??"
end
text = "<b> ??ÑÇÈÜØ ÇáÜãÜÌÜãÜæÚå • </b>\n"..linkgp
return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
end

if matches[1] == "ÇáÑÇÈØ ÎÇÕ" and is_mod(msg) then
local linkgp = data[tostring(chat)]['settings']['linkgp']
if not linkgp then

return "?? _Çæå ?? áÇ íæÌÏ åäÇ ÑÇÈØ_\n?? _ÑÌÇÆÇ ÇßÊÈ [ÖÚ ÑÇÈØ]_??"

end
tdcli.sendMessage(msg.from.id, 0, 1, "<code>??ÑÇÈÜØ ÇáÜãÜÌÜãÜæÚå •\n??"..msg.to.title.." :\n\n</code>"..linkgp..'\n', 1, 'html')
return "?? _ãÑÍÈÂ ÚÒíÒí_\n?? _Êã ÇÑÓÇá ÇáÑÇÈØ ÎÇÕ áß _??"

end

if matches[1] == "ÖÚ ŞæÇäíä" and matches[2] and is_mod(msg) then
data[tostring(chat)]['rules'] = matches[2]
save_data(_config.moderation.data, data)
return '?? _ãÑÍÈÂ ÚÒíÒí_\n?? _Êã ÍİÙ ÇáŞæÇäíä ÈäÌÇÍ_??\n?? _ÇßÊÈ [ ÇáŞæÇäíä ] áÚÑÖåÇ ??_'
end
if matches[1] == "ÇáŞæÇäíä" then
if not data[tostring(chat)]['rules'] then

rules = "?? _ãÑÍÈÃ ÚÒíÑí_ ???? _ÇáŞæÇäíä ßáÇÊí_ ????\n?? _ããäæÚ äÔÑ ÇáÑæÇÈØ_ \n?? _ããäæÚ ÇáÊßáã Çæ äÔÑ ÕæÑ ÇÈÇÍíå_ \n?? _ããäæÚ  ÇÚÇÏå ÊæÌíå_ \n?? _ããäæÚ ÇáÊßáã ÈáØÇÆİå_ \n?? _ÇáÑÌÇÁ ÇÍÊÑÇã ÇáãÏÑÇÁ æÇáÇÏãäíå _??\n?? _ÊÇÈÚ _@lBOSSl ??"

else
rules = "*??ÇáŞæÇäíä :*\n"..data[tostring(chat)]['rules']
end
return rules
end


if matches[1] == "ÖÚ ÊßÑÇÑ" and is_mod(msg) then
if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
return "?? _ÍÏæÏ ÇáÊßÑÇÑ ,  íÌÈ Çä Êßæä ãÇ Èíä _ *[2-50]*"
end
local flood_max = matches[2]
data[tostring(chat)]['settings']['num_msg_max'] = flood_max
save_data(_config.moderation.data, data)

return "??_ Êã æÖÚ ÇáÊßÑÇÑ :_ *[ "..matches[2].." ]*"

end

if matches[1] == "ãÓÍ" and is_owner(msg) then
if matches[2] == "ÇáÇÏãäíå" then
if next(data[tostring(chat)]['mods']) == nil then

return "?? _Çæå ? åäÇáß ÎØÃ_ ??\n?? _ÚĞÑÇ áÇ íæÌÏ ÇÏãäíå áíÊã ãÓÍåã_??"

end
for k,v in pairs(data[tostring(chat)]['mods']) do
data[tostring(chat)]['mods'][tostring(k)] = nil
save_data(_config.moderation.data, data)
end

return "?? _ãÑÍÈÂ ÚÒíÒí_ \n?? _Êã ÍĞİ ÇáÇÏãäíå ÈäÌÇÍ_ ??"

end
if matches[2] == "ŞÇÆãå ÇáãäÚ" then
if next(data[tostring(chat)]['filterlist']) == nil then

return "?? _ÚĞÑÇ áÇ ÊæÌÏ ßáãÇÊ ããäæÚå áíÊã ÍĞİåÇ_ ??"

end
for k,v in pairs(data[tostring(chat)]['filterlist']) do
data[tostring(chat)]['filterlist'][tostring(k)] = nil
save_data(_config.moderation.data, data)
end

return "?? _ãÑÍÈÂ ÚÒíÒí_ \n?? _Êã ÍĞİ ÇáßáãÇÊ ÇáããäæÚå ÈäÌÇÍ_ ??"

end
if matches[2] == "ÇáŞæÇäíä" then
if not data[tostring(chat)]['rules'] then


return "?? _Çæå ? åäÇáß ÎØÃ_ ??\n?? _ÚĞÑÇ áÇ íæÌÏ ŞæÇäíä áíÊã ãÓÍå_ ??"

end
data[tostring(chat)]['rules'] = nil
save_data(_config.moderation.data, data)

return "?? _ãÑÍÈÂ ÚÒíÒí_ \n?? _Êã ÍĞİ ÇáŞæÇäíä ÈäÌÇÍ_ ??"

end
if matches[2] == "ÇáÊÑÍíÈ"  then
if not data[tostring(chat)]['setwelcome'] then

return "?? _Çæå ? åäÇáß ÎØÃ_ ??\n?? _ÚĞÑÇ áÇ íæÌÏ ÊÑÍíÈ áíÊã ãÓÍå_ ??"

end
data[tostring(chat)]['setwelcome'] = nil
save_data(_config.moderation.data, data)

return "?? _ãÑÍÈÂ ÚÒíÒí_ \n?? _Êã ÍĞİ ÇáÊÑÍíÈ ÈäÌÇÍ_ ??"

end
if matches[2] == "ÇáæÕİ" then
if msg.to.type == "chat" then
if not data[tostring(chat)]['about'] then

return "?? _ÇæÈÓ ? åäÇáß ÎØÃ_ ??\n?? _ÚĞÑÇ áÇ íæÌÏ æÕİ áíÊã ãÓÍå_ ??"

end
data[tostring(chat)]['about'] = nil
save_data(_config.moderation.data, data)
elseif msg.to.type == "channel" then
tdcli.changeChannelAbout(chat, "", dl_cb, nil)
end

return "?? _ãÑÍÈÂ ÚÒíÒí_ \n?? _Êã ÍĞİ ÇáæÕİ ÈäÌÇÍ_ ??"

end
end
if matches[1] == "ãÓÍ" and is_sudo(msg) then
if matches[2] == "ÇáãÏÑÇÁ" then
if next(data[tostring(chat)]['owners']) == nil then

return "?? _ÇæÈÓ ? åäÇáß ÎØÃ_ ??\n?? _ÚĞÑÇ áÇ íæÌÏ ãÏÑÇÁ áíÊã ãÓÍåã_ ??"

end
for k,v in pairs(data[tostring(chat)]['owners']) do
data[tostring(chat)]['owners'][tostring(k)] = nil
save_data(_config.moderation.data, data)
end

return "?? _ãÑÍÈÂ ÚÒíÒí_ \n?? _Êã ÍĞİ ÇáãÏÑÇÁ ÈäÌÇÍ_ ??"

end
end
if matches[1] == "ÖÚ ÇÓã" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
if matches[1] == "ÖÚ ÕæÑå" and is_mod(msg) then
if tonumber(msg.reply_to_message_id_) ~= 0  then
function get_filemsg(arg, data)
function get_fileinfo(arg,data)
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

if data.content_.ID == 'MessagePhoto' then
local photo_id = data.content_.photo_.sizes_[2].photo_.id_
local file = data.content_.photo_.id_
local pathf = tcpath..'/data/photo/'..file..'_(1).jpg'
local cpath = tcpath..'/data/photo'
if file_exi(file..'_(1).jpg', cpath) then
local pfile = "./data/photo/group.jpg"
os.rename(pathf, pfile)
file_dl(photo_id)

 changeChatPhoto(msg.to.id, pfile)
return "?? _ãÑÍÈÂ ÚÒíÒí_ \n?? _Êã ÊÚííä ÕæÑå ááãÌãæÚå_ ??"
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_ÇÑÓá Çáãáİ ãÌÏÏÇ._', 1, 'md')
end
end
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
end
end
--[[
if tonumber(msg.reply_to_message_id_) ~= 0  then
function get_filemsg(arg, data)
function get_fileinfo(arg,data)
if data.content_.ID == 'MessagePhoto' then
local photo_id = data.content_.photo_.sizes_[2].photo_.id_ 
local file = data.content_.photo_.id_
local pathf = tcpath..'/data/photo/'..file..'_(1).jpg'
local cpath = tcpath..'/data/photo'
if file_exi(file..'_(1).jpg', cpath) then
local pfile = './data/photo'
os.rename(pathf, pfile)
file_dl(photo_id)
changeChatPhoto(msg.to.id, './data/'..file..'_(1).jpg')
else

tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')

end
end
end

tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
end

tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
end
]]

if matches[1] == "ÖÚ æÕİ" and matches[2] and is_mod(msg) then
if msg.to.type == "channel" then
tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
elseif msg.to.type == "chat" then
data[tostring(chat)]['about'] = matches[2]
save_data(_config.moderation.data, data)
end

return "?? _Êã æÖÚ ÇáæÕİ ÈäÌÇÍ_??"

end
if matches[1] == "ÇáæÕİ" and msg.to.type == "chat" and is_owner(msg) then
if not data[tostring(chat)]['about'] then

about = "?? _áÇ íæÌÏ æÕİ áíÊã ÚÑÖå _??*"

else
about = "?? *æÕİ ÇáãÌãæÚÉ :*\n"..data[tostring(chat)]['about']
end
return about
end
if matches[1] == "ãäÚ" and is_mod(msg) then
return filter_word(msg, matches[2])
end
if matches[1] == "ÇáÛÇÁ ãäÚ" and is_mod(msg) then
return unfilter_word(msg, matches[2])
end
if matches[1] == "ŞÇÆãå ÇáãäÚ" and is_mod(msg) then
return filter_list(msg)
end
if matches[1] == "ÇáÍãÇíå" and is_mod(msg) then
return group_settings(msg, target)
end
if matches[1] == "ÇáÇÚÏÇÏÇÊ" and is_mod(msg) then
list_settings = "?????` ÇÚÏÇÏÇÊ ÇáãÌãæÚå :` "
.."\n\n?? Şİá ÇáÊÚÏíá : "..settings.lock_edit
.."\n?? Şİá ÇáÑæÇÈØ : "..settings.lock_link
.."\n?? Şİá ÇáÇÖÇİå : "..settings.lock_join
.."\n?? Şİá ÇáÊÇß : "..settings.lock_tag
.."\n?? Şİá ÇáÊßÑÇÑ : "..settings.flood
.."\n?? Şİá ÇáßáÇíÔ : "..settings.lock_spam
.."\n?? Şİá ÇáæíÈ : "..settings.lock_webpage
.."\n?? Şİá ÇáãÇÑßÏæÇä : "..settings.lock_markdown
.."\n?? Şİá ÇáÊËÈíÊ : "..settings.lock_pin
.."\n?? Şİá ÇáÈæÊÇÊ : "..settings.lock_bots
.."\n?? ÚÏÏ ÇáÊßÑÇÑ : "..settings.num_msg_max
.."\n?? ãØæÑ ÇáÜÈÜæÊ : "..sudouser.."\n??????"

return list_settings
end
if matches[1] == "ÇáæÓÇÆØ" and is_mod(msg) then
return mutes(msg, target)
end
if matches[1] == "ÇáÇÏãäíå" and is_mod(msg) then
return modlist(msg)
end
if matches[1] == "ÇáãÏÑÇÁ" and is_owner(msg) then
return ownerlist(msg)
end
if matches[1] == "ÇáÇÚÖÇÁ ÇáããíÒíä" and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end

if matches[1] == "ØÑÏ ÇáÈæÊÇÊ" and not matches[2] and is_owner(msg) then
function delbots(arg, data)
local deleted = 0 
for k, v in pairs(data.members_) do
if v.user_id_ ~= our_id then

kick_user(v.user_id_, msg.to.id)
deleted = deleted + 1 
end
end
if deleted == 0 then
tdcli.sendMessage(msg.to.id, msg.id, 1, '?? áÇ íæÌÏ ÈæÊÇÊ İí ÇáãÌãæÚÉ ??????', 1, 'md')
else
tdcli.sendMessage(msg.to.id, msg.id, 1, '?? Êã ØÑÏ [<code>'..deleted..'</code>] ÈæÊ ãä ÇáãÌãæÚÉ ??????', 1, 'html')
end
end
tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, delbots, nil)
end

if matches[1] == "ßÔİ ÇáÈæÊÇÊ" and not matches[2] and is_owner(msg) then
function kshf(arg, data)
local i = 0
for k, v in pairs(data.members_) do
if v.user_id_ ~= our_id then

i = i + 1
end
end
if i == 0 then
tdcli.sendMessage(msg.to.id, msg.id, 1, '?? áÇ íæÌÏ ÈæÊÇÊ İí ÇáãÌãæÚÉ ??????', 1, 'md')
else
tdcli.sendMessage(msg.to.id, msg.id, 1, '?? ÚÏÏ ÇáÈæÊÇÊ ÇáãæÌæÏÉ [<code>'..i..'</code>] ÈæÊ??????',1, 'html')
end
end
tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, kshf, nil)
end


--------------------- Welcome -----------------------
if matches[1] == "ÊİÚíá" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "ÇáÑÏæÏ" then
return unlock_replay(msg, data, target)
end
if matches[2] == "ÇáÇĞÇÚå" and is_sudo(msg) then
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "??åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ " 
end
redis:set("lock_brod","yes")
return unlock_brod(msg, data, target)
end
if matches[2] == "ÇáÇíÏí" then
lock_id = data[tostring(chat)]['settings']['lock_id']
if lock_id == "??" then
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _ÇãÑ ÇáÇíÏí ÔÛÇá ÈÇáİÚá_ ??"
else
data[tostring(chat)]['settings']['lock_id'] = "??"
save_data(_config.moderation.data, data)
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _Êã ÊİÚíá ÇãÑ ÇáÇíÏí_ ??"
end
end

if matches[2] == "ÇáÊÑÍíÈ" then
welcome = data[tostring(chat)]['settings']['welcome']
if welcome == "??" then
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _ÊİÚíá ÇáÊÑÍíÈ ãİÚá ãÓÈŞÇğ_ ??"
else
data[tostring(chat)]['settings']['welcome'] = "??"
save_data(_config.moderation.data, data)
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _Êã ÊİÚíá ÇáÊÑÍíÈ_ ??"
end
end

if matches[2] == "ÇáÊÍĞíÑ" then
lock_woring = data[tostring(chat)]['settings']['lock_woring']
if lock_woring == "??" then
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _ÊİÚíá ÇáÊÍĞíÑ ãİÚá ãÓÈŞÇğ_ ??"
else
data[tostring(chat)]['settings']['lock_woring'] = "??"
save_data(_config.moderation.data, data)
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _Êã ÊİÚíá ÇáÊÍĞíÑ_ ??"
end
end
end
if matches[1] == "ÊÚØíá" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "ÇáÑÏæÏ" then
return lock_replay(msg, data, target)
end
if matches[2] == "ÇáÇĞÇÚå" and is_sudo(msg) then
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "??åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ " 
end
redis:set("lock_brod","no")
return lock_brod(msg, data, target)
end

if matches[2] == "ÇáÇíÏí" then
lock_id = data[tostring(chat)]['settings']['lock_id']
if lock_id == "??" then
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _ÇáÇíÏí ÈÇáÊÃßíÏ ãÚØá_ ??"
else
data[tostring(chat)]['settings']['lock_id'] = "??"
save_data(_config.moderation.data, data)
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _Êã ÊÚØíá ÇãÑ ÇáÇíÏí_ ??"
end
end


if matches[2] == "ÇáÊÑÍíÈ" then
welcome = data[tostring(chat)]['settings']['welcome']
if welcome == "??" then
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _ÇáÊÑÍíÈ ÈÇáÊÃßíÏ ãÚØá_ ??"
else
data[tostring(chat)]['settings']['welcome'] = "??"
save_data(_config.moderation.data, data)
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _Êã ÊÚØíá ÇáÊÑÍíÈ_ ??"
end
end

if matches[2] == "ÇáÊÍĞíÑ" then
lock_woring = data[tostring(chat)]['settings']['lock_woring']
if lock_woring == "??" then
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _ÇáÊÍĞíÑ ÈÇáÊÃßíÏ ãÚØá_ ??"
else
data[tostring(chat)]['settings']['lock_woring'] = "??"
save_data(_config.moderation.data, data)
return "?? _ãÑÍÈÇ ÚÒíÒí_\n?? _Êã ÊÚØíá ÇáÊÍĞíÑ_ ??"
end
end
end
if matches[1] == "ÖÚ ÇáÊÑÍíÈ" and matches[2] and is_mod(msg) then
data[tostring(chat)]['setwelcome'] = matches[2]
save_data(_config.moderation.data, data)
return "?? _Êã æÖÚ ÇáÊÑÍíÈ ÈäÌÇÍ ßáÇÊí ????_\n*"..matches[2].."*\n\n?? _ãáÇÍÙå_\n?? _ÊÓÊØíÚ ÇÖåÇÑ ÇáŞæÇäíä ÈæÇÓØå _ ? *{rules}*  \n?? _ÊÓÊØíÚ ÇÖåÇÑ ÇáÇÓã ÈæÇÓØå_ ? *{name}*\n?? _ÊÓÊØíÚ ÇÖåÇÑ ÇáãÚÑİ ÈæÇÓØå_ ? *{username}*"
end
if matches[1] == "ÇáÊÑÍíÈ"  and is_mod(msg) then
if data[tostring(chat)]['setwelcome']  then
return data[tostring(chat)]['setwelcome']  
else
return "?? ãÑÍÈÇğ ÚÒíÒí\n?? äæÑÊ ÇáãÌãæÚå \n?? ÊÇÈÚ : @lBOSSl \n??????"
end
end

end
end
-----------------------------------------
local checkmod = true

local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local data = load_data(_config.moderation.data)
if checkmod and msg.text and msg.to.type == 'channel' then
checkmod = false
tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
local secchk = true
for k,v in pairs(b.members_) do
if v.user_id_ == tonumber(our_id) then
secchk = false
end
end
if secchk then
checkmod = false
return tdcli.sendMessage(msg.to.id, 0, 1, '?? ÇáÈæÊ áíÓ ÇÏãä İí ÇáãÌãæÚÉ\n?? íÑÌí ÑİÚ ÇáÈæÊ ÇÏãä ', 1, "md")
end
end, nil)
end
local function welcome_cb(arg, data)
administration = load_data(_config.moderation.data)
if administration[arg.chat_id]['setwelcome'] then
welcome = administration[arg.chat_id]['setwelcome']
else
welcome = "?? ãÑÍÈÇğ ÚÒíÒí\n?? äæÑÊ ÇáãÌãæÚÉ \n?? ÊÇÈÚ : @lBOSSl\n??????"
end
if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
rules = "?? _ãÑÍÈÃ ÚÒíÑí_ ???? _ÇáŞæÇäíä ßáÇÊí_ ????\n?? _ããäæÚ äÔÑ ÇáÑæÇÈØ_ \n?? _ããäæÚ ÇáÊßáã Çæ äÔÑ ÕæÑ ÇÈÇÍíå_ \n?? _ããäæÚ  ÇÚÇÏå ÊæÌíå_ \n?? _ããäæÚ ÇáÊßáã ÈáØÇÆİå_ \n?? _ÇáÑÌÇÁ ÇÍÊÑÇã ÇáãÏÑÇÁ æÇáÇÏãäíå _??\n?? _ÊÇÈÚ _@lBOSSl ??\n??????"

end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
local welcome = welcome:gsub("{rules}", rules)
local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
local welcome = welcome:gsub("{username}", user_name)
local welcome = welcome:gsub("{gpname}", arg.gp_name)
tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
end
if data[tostring(chat)] and data[tostring(chat)]['settings'] then


if msg.adduser then


welcome = data[tostring(msg.to.id)]['settings']['welcome']
if welcome == "??" and msg.adduser ~= tonumber(our_id) then
tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
else
return false
end
end
if msg.joinuser then

welcome = data[tostring(msg.to.id)]['settings']['welcome']
if welcome == "??" and msg.adduser ~= tonumber(our_id) then
tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
else
return false
end
end
end

end

return {
patterns ={
"^(ÇíÏí)$",
"^(ÇíÏí) (.*)$",
'^(ÇáÍãÇíå)$',
'^(ÇáÇÚÏÇÏÇÊ)$',
'^(ÇáæÓÇÆØ)$',
'^(ÊËÈíÊ)$',
'^(ÇáÛÇÁ ÇáÊËÈíÊ)$',
'^(ÊİÚíá)$',
'^(ÊÚØíá)$',
'^(ÑİÚ ÇáãÏíÑ)$',
'^(ÑİÚ ÇáãíÑ) (.*)$',
'^(ÊäÒíá ÇáãíÑ) (.*)$',
'^(ÊäÒíá ÇáãÏíÑ)$',
'^(ÑİÚ ÚÖæ ããíÒ) (.*)$',
'^(ÊäÒíá ÚÖæ ããíÒ) (.*)$',
'^(ÑİÚ ÚÖæ ããíÒ)$',
'^(ÊäÒíá ÚÖæ ããíÒ)$',
'^(ÇáÇÚÖÇÁ ÇáããíÒíä)$',
'^(ÑİÚ ÇÏãä)$',
'^(ÑİÚ ÇÏãä) (.*)$',
'^(ÊäÒíá ÇÏãä) (.*)$',
'^(ÊäÒíá ÇÏãä)$',
'^(ÑİÚ ÇáãÏíÑ)$',
'^(ÑİÚ ÇáãÏíÑ) (.*)$',
'^(ÊäÒíá ÇáãÏíÑ)$',
'^(ÊäÒíá ÇáãÏíÑ) (.*)$',
'^(Şİá) (.*)$',
'^(İÊÍ) (.*)$',
'^(ÊİÚíá) (.*)$',
'^(ÊÚØíá) (.*)$',
'^(ÇáÑÇÈØ ÎÇÕ)$',
'^(ÊÛíÑ ÇáÑÇÈØ)$',
'^(ÇáãÌãæÚå)$',
'^(ÇáŞæÇäíä)$',
'^(ÇáÑÇÈØ)$',
'^(ÖÚ ÑÇÈØ)$',
'^(ÖÚ ŞæÇäíä) (.*)$',
'^(ÖÚ ÊßÑÇÑ) (%d+)$',
'^(ãÓÍ) (.*)$',
'^(ÇáæÕİ)$',
'^(ÖÚ ÕæÑå)$',
'^(ÖÚ æÕİ) (.*)$',
'^(ÖÚ ÇÓã) (.*)$',
'^(ŞÇÆãå ÇáãäÚ)$',
'^(ÇáãÏÑÇÁ)$',
'^(ÇáÇÏãäíå)$',
'^(ØÑÏ ÇáÈæÊÇÊ)$',
'^(ßÔİ ÇáÈæÊÇÊ)$',
'^(ãäÚ) (.*)$',
'^(ÇáÛÇÁ ãäÚ) (.*)$',
'^(ÖÚ ÇáÊÑÍíÈ) (.*)$',
'^(ÇáÊÑÍíÈ)$',
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^!!tgservice (.+)$",
},
run=moody,
pre_process = pre_process
}