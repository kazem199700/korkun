local function pre_process(msg)
   if msg.to.type ~= 'pv' then
chat = msg.to.id
user = msg.from.id
local function check_newmember(arg, data)

if data.type_.ID == "UserTypeBot" then
test = load_data(_config.moderation.data)
lock_bots = test[arg.chat_id]['settings']['lock_bots']
if not is_owner(arg.msg) and lock_bots == '??' then
kick_user(data.id_, arg.chat_id)
end
end

if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end

if is_banned(data.id_, arg.chat_id) then
tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÍÙÑå ??_', 0, "md")
kick_user(data.id_, arg.chat_id)
end

if is_gbanned(data.id_) then
tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÍÙÑå ÚÇã ??_', 0, "md")
kick_user(data.id_, arg.chat_id)
end
end

if msg.adduser then
tdcli_function ({
ID = "GetUser",
user_id_ = msg.adduser
}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
end

if msg.joinuser then
tdcli_function ({
ID = "GetUser",
user_id_ = msg.joinuser
}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
end
end
   -- return msg
end

local function action_by_reply(arg, data)
  local cmd = arg.cmd

if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then
  if cmd == "ban" then
local function ban_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
     if data.id_ == our_id then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_mod1(arg.chat_id, data.id_) then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ÍÙÑå ??_', 0, "md")
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÍÙÑå ??_', 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
   if cmd == "unban" then
local function unban_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end

if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ÇáÛÇÁ ÍÙÑå ??_', 0, "md")
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
channel_unblock(arg.chat_id, data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÇáÛÇÁ ÍÙÑå ??_', 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "silent" then
local function silent_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
     if data.id_ == our_id then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ßÊã ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_mod1(arg.chat_id, data.id_) then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ßÊã ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ßÊãå ??_', 0, "md")
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ßÊãå ??_', 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unsilent" then
local function unsilent_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÈÇáÊÇßíÏ ÇáÛÇÁ ßÊãå ??_', 0, "md")
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÇáÛÇÁ ßÊãå ??_', 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "banall" then
local function gban_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
     if data.id_ == our_id then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_sudo1(data.id_) then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
if is_gbanned(data.id_) then
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _  Êã ÈÇáÊÃßíÏ ÍÙÑå ÚÇã ??_', 0, "md")
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n??  _ÇáÇíÏí ?_* ['..data.id_..']*\n?? _ Êã ÍÙÑå ÚÇã  ??_', 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, gban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unbanall" then
local function ungban_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = data.first_name_
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ * ['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ÇáÛÇÁ ÍÙÑå ÇáÚÇã ??_', 0, "md")
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ * ['..data.id_..']*\n?? _ Êã ÇáÛÇÁ ÍÙÑå ÇáÚÇã ??_', 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ungban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "kick" then

     if data.sender_user_id_ == our_id then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*??  áÇ ÊÓÊØíÚ ØÑÏ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
   elseif is_mod1(data.chat_id_, data.sender_user_id_) then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*??  áÇ ÊÓÊØíÚ ØÑÏ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
  else

     kick_user(data.sender_user_id_, data.chat_id_)
    sleep(1)
	channel_unblock(data.chat_id_, data.sender_user_id_)
tdcli.sendMessage(data.chat_id_,  arg.msg_id, 0, "?? ãÑÍÈÇ ÚÒíÒí \n?? Êã ØÑÏ ÇáÚÖæ ? ","md")

end

end
    
else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*áã íÊã ÇáÚËæÑ Úáì ÇáÚÖæ ?*", 0, "md")
   end
end
local function action_by_username(arg, data)
  local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..data.type_.user_.username_
else
user_name = check_markdown(data.title_)
end
  if cmd == "ban" then
     if data.id_ == our_id then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_mod1(arg.chat_id, data.id_) then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
     return  tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ÍÙÑå ??_', 0, "md")
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÍÙÑå ??_', 0, "md")
end  
  if cmd == "unban" then
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ÇáÛÇÁ ÍÙÑå ??_', 0, "md")
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
channel_unblock(arg.chat_id, data.id_)

    return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÇáÛÇÁ ÍÙÑå ??_', 0, "md")
   
end
  if cmd == "silent" then
     if data.id_ == our_id then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ßÊã ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_mod1(arg.chat_id, data.id_) then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ßÊã ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ßÊãå ??_', 0, "md")
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ßÊãå ??_', 0, "md")
end
  if cmd == "unsilent" then
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ÇáÛÇÁ ßÊãå ??_', 0, "md")
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ÇáÛÇÁ ßÊãå ??_', 0, "md")
end
  if cmd == "banall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
     if data.id_ == our_id then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_sudo1(data.id_) then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
if is_gbanned(data.id_) then
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ÍÙÑå ÚÇã ??_', 0, "md")
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÍÙÑå ÚÇã ??_', 0, "md")
end
  if cmd == "unbanall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _ Êã ÈÇáÊÃßíÏ ÇáÛÇÁ ÍÙÑå ÇáÚÇã ??_', 0, "md")
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
     return tdcli.sendMessage(arg.chat_id, "", 0, '?? _ÇáÚÖæ ?_ ['..user_name..'] \n?? _ÇáÇíÏí ?_ *['..data.id_..']*\n?? _  Êã ÇáÛÇÁ ÍÙÑå ÇáÚÇã ??_', 0, "md")
end
  if cmd == "kick" then
     if data.id_ == our_id then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ØÑÏ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
   elseif is_mod1(arg.chat_id, data.id_) then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*?? áÇ ÊÓÊØíÚ ØÑÏ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
  else
kick_user(data.id_, arg.chat_id)
  sleep(1)
channel_unblock(arg.chat_id, data.id_)
tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "?? ãÑÍÈÇ ÚÒíÒí \n?? Êã ØÑÏ ÇáÚÖæ ? "..check_markdown(user_name).."","md")
end
end

else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_áã íÊã ÇáÚËæÑ Úáì ÇáÚÖæ ?_", 0, "md")
   end
end
local function moody(msg, matches)
local userid = tonumber(matches[2])
local data = load_data(_config.moderation.data)
chat = msg.to.id
user = msg.from.id
   if msg.to.type ~= 'pv' then
 if matches[1] == "ØÑÏ" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,msg_id=msg.id,cmd="kick"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
    if userid == our_id then
     tdcli.sendMessage(msg.chat_id_, "", 0, "*?? áÇ ÊÓÊØíÚ ØÑÏ ÇáãÏÑÇÁ ÇæÇáÇÏãäíå*", 0, "md")
   elseif is_mod1(msg.to.id, userid) then
     tdcli.sendMessage(msg.chat_id_, "", 0, "*?? áÇ ÊÓÊØíÚ ØÑÏ ÇáãÏÑÇÁ ÇæÇáÇÏãäíå*", 0, "md")
     else
kick_user(matches[2], msg.to.id)
   sleep(1)
channel_unblock(msg.to.id, matches[2])
tdcli.sendMessage(msg.chat_id_, msg.id, 0, "?? ãÑÍÈÇ ÚÒíÒí \n?? Êã ØÑÏ ÇáÚÖæ ? [`"..matches[2].."`]","md")
end
   end
  if matches[2] and string.match(matches[2], '@[%a%d_]') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,msg_id=msg.id,username=matches[2],cmd="kick"})
         end
  end
if matches[1] == "ãÓÍ" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
del_msg(msg.to.id, msg.reply_id)
del_msg(msg.to.id, msg.id)
end
end
  
 if matches[1] == "ÍÙÑ ÚÇã" and is_sudo(msg)  then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="banall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
    if matches[2] == our_id then
    return tdcli.sendMessage(msg.to.id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_sudo1(matches[2]) then
    return tdcli.sendMessage(msg.to.id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_gbanned(matches[2]) then
  return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *('..matches[2]..')*\n?? _ Êã ÈÇáÊÃßíÏ ÍÙÑå ÚÇã ??_', 0, "md")
     end
  data['gban_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.to.id)

 return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *('..matches[2]..')*\n?? _ Êã ÍÙÑå ÚÇã ??_', 0, "md")
      
   end
  if matches[2] and string.match(matches[2], '@[%a%d_]') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="banall"})
      end
   end
 if matches[1] == "ÇáÛÇÁ ÇáÚÇã" and is_sudo(msg)  then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unbanall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_gbanned(matches[2]) then
   return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ÈÇáÊÃßíÏ ÇáÛÇÁ ÍÙÑå ÇáÚÇã ??_', 0, "md")
     end
  data['gban_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ÇáÛÇÁ ÍÙÑå ÇáÚÇã ??_', 0, "md")
   end
  if matches[2] and string.match(matches[2], '@[%a%d_]') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unbanall"})
      end
   end
 if matches[1] == "ÍÙÑ" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="ban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
    if matches[2] == our_id then

    return tdcli.sendMessage( msg.to.id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
        
     end
   if is_mod1(msg.to.id, matches[2]) then

    return tdcli.sendMessage( msg.to.id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
        
     end
   if is_banned(matches[2], msg.to.id) then

  return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ÈÇáÊÃßíÏ ÍÙÑå ??_', 0, "md")
        
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.to.id)
 return tdcli.sendMessage( msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ÍÙÑå ??_', 0, "md")
   end
  if matches[2] and string.match(matches[2], '@[%a%d_]') then
     tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ban"})
      end
   end
 if matches[1] == "ÇáÛÇÁ ÇáÍÙÑ" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_banned(matches[2], msg.to.id) then
   return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ÈÇáÊÃßíÏ ÇáÛÇÁ ÍÙÑå ??_', 0, "md")
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
channel_unblock(msg.to.id, matches[2])
return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ÇáÛÇÁ ÍÙÑå ??_', 0, "md")
      
   end
  if matches[2] and string.match(matches[2], '@[%a%d_]') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unban"})
      end
   end
 if matches[1] == "ßÊã" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="silent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
    if matches[2] == our_id then
   return tdcli.sendMessage(msg.to.id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_mod1(msg.to.id, matches[2]) then
   return tdcli.sendMessage(msg.to.id, "", 0, "*?? áÇ ÊÓÊØíÚ ÍÙÑ ÇáãÏÑÇÁ Çæ ÇáÇÏãäíå*", 0, "md")
     end
   if is_silent_user(matches[2], chat) then
   return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ÈÇáÊÃßíÏ ßÊãå ??_', 0, "md")
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ßÊãå ??_', 0, "md")
   end
  if matches[2] and string.match(matches[2], '@[%a%d_]') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="silent"})
      end
   end
 if matches[1] == "ÇáÛÇÁ ÇáßÊã" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unsilent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_silent_user(matches[2], chat) then
return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ÈÇáÊÃßíÏ ÇáÛÇÁ ßÊãå ??_', 0, "md")
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
return tdcli.sendMessage(msg.to.id, "", 0, '?? _ÇáÇíÏí ?_ *['..matches[2]..']*\n?? _ Êã ÇáÛÇÁ ßÊãå ??_', 0, "md")
   end
  if matches[2] and string.match(matches[2], '@[%a%d_]') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unsilent"})
      end
   end
if matches[1] == "ãÓÍ" and is_owner(msg)  then
			if matches[2] == 'ÇáãÍÙæÑíä'  then
				if next(data[tostring(chat)]['banned']) == nil then
					return "*?? áÇ íæÌÏ ãÓÊÎÏãíä ãÍÙæÑíä İí åĞå ÇáãÌãæÚå*"
				end
				for k,v in pairs(data[tostring(chat)]['banned']) do
					data[tostring(chat)]['banned'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*?? Êã ÇáÛÇÁ ÇáÍÙÑ Úä ÌãíÚ ÇáãÓÊÎÏãíä İí åĞå ÇáãÌãæÚå*"
			end
			
			if matches[2] == 'ÇáãßÊæãíä'  then
				if next(data[tostring(chat)]['is_silent_users']) == nil then
					return "*?? áÇ íæÌÏ ãÓÊÎÏãíä ãßÊæãíä İí ÇáãÌãæÚå *"
				end
				for k,v in pairs(data[tostring(chat)]['is_silent_users']) do
					data[tostring(chat)]['is_silent_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
				return "*?? Êã ãÓÍ ŞÇÆãå ÇáßÊã*"
			    end
     		if matches[2] == 'ÇáããíÒíä'  then
				if next(data[tostring(chat)]['whitelist']) == nil then
					return "*?? áÇ íæÌÏ ÇÚÖÇÁ ããíÒíä İí ÇáãÌãæÚå *"
				end
				for k,v in pairs(data[tostring(chat)]['whitelist']) do
					data[tostring(chat)]['whitelist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
				return "*?? Êã ãÓÍ ÇáããíÒíä ????*"
			    end
        end
     end
if matches[1] == "ãÓÍ" and is_sudo(msg)  then

if matches[2] == 'ÇáãØæÑíä'  then
if tonumber(msg.from.id) ~= tonumber(SUDO) then return ??åĞÇ ÇáÇæÇãÑ ááãØæÑ ÇáÇÓÇÓí İŞØ ??" end
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
local i =0
  for v,user in pairs(_config.sudo_users) do
if user[1] ~= SUDO then
table.remove(_config.sudo_users, index_function(tonumber(user[1])))
i=i+1
end
end
if i == 0 then
return "*??¦ áÇ íæÌÏ ãØæÑíä ãÖÇİíä  ??*"
else
return "*??¦ Êã ãÓÍ `"..i.."` ãØæÑ ??*"
end
end
				
			if matches[2] == 'ŞÇÆãå ÇáÚÇã'  then
				if next(data['gban_users']) == nil then
					return "*??¦ áÇ íæÌÏ ãÓÊÎÏãíä ãÍÙæÑíä ÚÇã İí ÇáãÌãæÚå *"
				end
				for k,v in pairs(data['gban_users']) do
					data['gban_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*??¦ Êã ÇáÛÇÁ ÇáÍÙÑ Úä ÌãíÚ ÇáãÓÊÎÏãíä ÇáãÍÙæÑíä ÚÇã ãä ÇáãÌãæÚå*"
			end
     end
 if matches[1] == "ŞÇÆãå ÇáÚÇã" and is_sudo(msg)  then
  return gbanned_list(msg)
 end
   if msg.to.type ~= 'pv' then
 if matches[1] == "ÇáãßÊæãíä" and is_mod(msg)  then
  return silent_users_list(chat)
 end
 if matches[1] == "ÇáãÍÙæÑíä" and is_mod(msg)  then
  return banned_list(chat)
     end
  end
end
return {
	patterns = {

 "^(ãÓÍ Çáßá)$",
 "^(ãÓÍ Çáßá) (@[%a%d%_]+)$",
 "^(ãÓÍ Çáßá) (%d+)$",
"^(ÍÙÑ ÚÇã) (@[%a%d%_]+)$",
"^(ÍÙÑ ÚÇã) (%d+)$",
"^(ÍÙÑ ÚÇã)$",
"^(ÇáÛÇÁ ÇáÚÇã) (@[%a%d%_]+)$",
"^(ÇáÛÇÁ ÇáÚÇã) (%d+)$",
"^(ÇáÛÇÁ ÇáÚÇã)$",
"^(ÍÙÑ) (@[%a%d%_]+)$",
"^(ÍÙÑ) (%d+)$",
"^(ÍÙÑ)$",
"^(ÇáÛÇÁ ÇáÍÙÑ) (@[%a%d%_]+)$",
"^(ÇáÛÇÁ ÇáÍÙÑ) (%d+)$",
"^(ÇáÛÇÁ ÇáÍÙÑ)$",
"^(ØÑÏ) (@[%a%d%_]+)$",
"^(ØÑÏ) (%d+)$",
"^(ØÑÏ)$",
"^(ßÊã) (@[%a%d%_]+)$",
"^(ßÊã) (%d+)$",
"^(ßÊã)$",
"^(ÇáÛÇÁ ÇáßÊã) (@[%a%d%_]+)$",
"^(ÇáÛÇÁ ÇáßÊã) (%d+)$",
"^(ÇáÛÇÁ ÇáßÊã)$",
"^(ÇáãÍÙæÑíä)$",
"^(ŞÇÆãå ÇáÚÇã)$",
"^(ÇáãßÊæãíä)$",
"^(ãÓÍ)$",
"^(ãÓÍ) (.*)$",
},
run = moody,
pre_process = pre_process
}