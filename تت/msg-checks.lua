--Begin msg_checks.lua By @TH3BOSS
local function pre_process(msg)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
local is_channel = msg.to.type == "channel"


if not redis:get('autodeltime') then
	redis:setex('autodeltime', 1440, true)
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
	 run_bash("rm -rf ./data/photos/*")
end
if msg.from.username then -- İÇäßÔä ÇáíæÒÑäíã
usernamex = "@"..(msg.from.username or "---")
member = "@"..(msg.from.username or "---")
else
usernamex = "ãÇ ãÓæí  ????"
member = name_user
end


if is_channel then

local TIME_CHECK = 2

if data[tostring(chat)] then
if data[tostring(chat)]['settings']['time_check'] then
TIME_CHECK = tonumber(data[tostring(chat)]['settings']['time_check'])
end
end


if data[tostring(chat)] and data[tostring(chat)]['mutes'] then
mutes = data[tostring(chat)]['mutes']
else
return
end

	if mutes.mute_gif then
		mute_gif = mutes.mute_gif
	else
		mute_gif = '??'
	end
   if mutes.mute_photo then
		mute_photo = mutes.mute_photo
	else
		mute_photo = '??'
	end
	if mutes.mute_sticker then
		mute_sticker = mutes.mute_sticker
	else
		mute_sticker = '??'
	end
	if mutes.mute_contact then
		mute_contact = mutes.mute_contact
	else
		mute_contact = '??'
	end
	if mutes.mute_inline then
		mute_inline = mutes.mute_inline
	else
		mute_inline = '??'
	end
	if mutes.mute_game then
		mute_game = mutes.mute_game
	else
		mute_game = '??'
	end
	if mutes.mute_text then
		mute_text = mutes.mute_text
	else
		mute_text = '??'
	end
	if mutes.mute_keyboard then
		mute_keyboard = mutes.mute_keyboard
	else
		mute_keyboard = '??'
	end
	if mutes.mute_forward then
		mute_forward = mutes.mute_forward
	else
		mute_forward = '??'
	end
	if mutes.mute_location then
		mute_location = mutes.mute_location
	else
		mute_location = '??'
	end
   if mutes.mute_document then
		mute_document = mutes.mute_document
	else
		mute_document = '??'
	end
	if mutes.mute_voice then
		mute_voice = mutes.mute_voice
	else
		mute_voice = '??'
	end
	if mutes.mute_audio then
		mute_audio = mutes.mute_audio
	else
		mute_audio = '??'
	end
	if mutes.mute_video then
		mute_video = mutes.mute_video
	else
		mute_video = '??'
	end
	if mutes.mute_tgservice then
		mute_tgservice = mutes.mute_tgservice
	else
		mute_tgservice = '??'
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
		settings = data[tostring(chat)]['settings']
	else
		return
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = '??'
	end
	if settings.lock_join then
		lock_join = settings.lock_join
	else
		lock_join = '??'
	end
	if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = '??'
	end
	if settings.lock_pin then
		lock_pin = settings.lock_pin
	else
		lock_pin = '??'
	end
	if settings.lock_mention then
		lock_mention = settings.lock_mention
	else
		lock_mention = '??'
	end
		if settings.lock_edit then
		lock_edit = settings.lock_edit
	else
		lock_edit = '??'
	end
		if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = '??'
	end
	if settings.flood then
		lock_flood = settings.flood
	else
		lock_flood = '??'
	end
	if settings.lock_markdown then
		lock_markdown = settings.lock_markdown
	else
		lock_markdown = '??'
	end
	if settings.lock_webpage then
		lock_webpage = settings.lock_webpage
	else
		lock_webpage = '??'
	end
		if settings.lock_woring then
		lock_woring = settings.lock_woring
	else
		lock_woring = '??'
	end
	
	
	

	    
if msg.adduser or msg.joinuser or msg.deluser then -- Şİá ÇáÇÔÚÇÑÇÊ
if mute_tgservice == "??" then
del_msg(chat, tonumber(msg.id))
end
end


if msg.pinned then -- Şİá ÇáÊËÈíÊ
if lock_pin == "??" then
if is_owner(msg) then return end
if tonumber(msg.from.id) == our_id then return end
local pin_msg = data[tostring(chat)]['pin']
if pin_msg then
tdcli.pinChannelMessage(msg.to.id, pin_msg, 1)
elseif not pin_msg then
tdcli.unpinChannelMessage(msg.to.id)
end
return tdcli.sendMessage(msg.to.id, msg.id, 0, '<b>??  ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>??  ÇáãÚÑİ ? :</b> '..usernamex..'\n<i>?? ÚĞÑÇ ÇáÊËÈíË İí åĞå ÇáãÌãæÚå ãŞİá ?  </i>', 0, "html")
end
end




if not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) and msg.from.id ~= our_id then -- ááÇÚÖÇÁ İŞØ

if msg.to.type ~= 'pv' then
  
if lock_flood == "??" and not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) and not msg.adduser and msg.from.id ~= our_id then
local hash = 'user:'..user..':msgs'
local msgs = tonumber(redis:get(hash) or 0)
local NUM_MSG_MAX = 5
if data[tostring(chat)] then
if data[tostring(chat)]['settings']['num_msg_max'] then
NUM_MSG_MAX = tonumber(data[tostring(chat)]['settings']['num_msg_max'])
end
end
if msgs > NUM_MSG_MAX then
if msg.from.username then
user_name = "@"..msg.from.username
else
user_name = msg.from.first_name
end
if redis:get('sender:'..user..':flood') then
return
else
del_msg(chat, msg.id)
kick_user(user, chat)
tdcli.sendMessage(chat, msg.id, 0, "_??  ÇáÚÖæ ?_ :  "..user_name.."\n _?? ÇáÇíÏí ?_ : `["..user.."]`\n _??  ÚĞÑÇ ããäæÚ ÇáÊßÑÇÑ İí åĞå ÇáãÌãæÚå áŞÏ Êã ØÑÏß ??_\n", 0, "md")
redis:setex('sender:'..user..':flood', 30, true)
end
end
redis:setex(hash, TIME_CHECK, msgs+1)
end
end

if msg and is_silent_user(msg.from.id, msg.to.id) then -- ÇáßÊã
del_msg(chat, tonumber(msg.id))
end

if msg.text and mute_text == "??" then --Şİá ÇáÏÑÏÔå
del_msg(chat, tonumber(msg.id))
end

if msg and mute_all == "??" then -- Şİá ÇáãÌãæÚå
 del_msg(chat, tonumber(msg.id))
end
   
if msg.adduser or msg.joinuser then -- Şİá ÇáÇÖÇİå
if lock_join == "??" then
function join_kick(arg, data)
kick_user(data.id_, msg.to.id)
end
if msg.adduser then
tdcli.getUser(msg.adduser, join_kick, nil)
elseif msg.joinuser then
tdcli.getUser(msg.joinuser, join_kick, nil)
end
end
end



if msg.forward_info_ and mute_forward == "??" then -- Şİá ÇáÊæÌíå
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÚÇÏÉ ÇáÊæÌíå  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif tonumber(msg.via_bot_user_id_) ~= 0 and mute_inline == "??" then -- Şİá ÇáÇäáÇíä
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ÇáÇäáÇíä ãŞİæá  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end

elseif msg.media.caption then -- ÇáÑÓÇíá Çáí ÈÇáßÇÈÔä

if (msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.media.caption:match("[Tt].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.caption:match(".[Pp][Ee]")) and lock_link == "??" then
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáÑæÇÈØ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif (msg.media.caption:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.media.caption:match("[Hh][Tt][Tt][Pp]://") or msg.media.caption:match("[Ww][Ww][Ww].") or msg.media.caption:match(".[Cc][Oo][Mm]")) and lock_webpage == "??" then
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÑæÇÈØ ÇáæíÈ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif (msg.media.caption:match("@") or msg.media.caption:match("#")) and lock_tag == "??" then
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáÊÇß Çæ ÇáãÚÑİ ?  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif is_filter(msg, msg.media.caption) then
del_msg(chat, tonumber(msg.id))
end

elseif msg.text then -- ÑÓÇíá İŞØ
    
local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
local max_chars = 2000
local max_len =  2000
if (string.len(msg.text) > max_len or ctrl_chars > max_chars) and lock_spam == "??"  then
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ããäæÚ ÇÑÓÇá ÇáßáíÔå æÇáÇ Óæİ ÊÌÈÑäí Úáì ØÑÏß  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.text == "[unsupported]" and mute_video == "??" then -- Şİá ÇáİíÏíæ
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáİíÏíæ ßÇã ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif (msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.text:match("[Tt].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.text:match(".[Pp][Ee]")) and lock_link == "??" then
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ããäæÚ ÇÑÓÇá ÇáÑæÇÈØ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text:match("[Hh][Tt][Tt][Pp]://") or msg.text:match("[Ww][Ww][Ww].") or msg.text:match(".[Cc][Oo][Mm]")) and lock_webpage == "??" then
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ããäæÚ ÇÑÓÇá ÑæÇÈØ ÇáæíÈ   ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif (msg.text:match("@") or msg.text:match("#")) and lock_tag == "??" then
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ããäæÚ ÇÑÓÇá ÇáãÚÑİ ? Çæ ÇáÊÇß  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif is_filter(msg, msg.text) then
del_msg(chat, tonumber(msg.id))
end

   
elseif msg.edited and lock_edit == "??" then -- Şİá ÇáÊÚÏíá
 del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "?? ÚĞÑÇğ ããäæÚ ÇáÊÚÏíá Êã ÇáãÓÍ ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.photo_ and mute_photo == "??" then -- ŞİÈ ÇáÕæÑ
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáÕæÑ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.video_ and mute_video == "??" then -- Şİá ÇáİíÏíæ
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáİíÏíæ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.document_ and mute_document == "??" then -- Şİá ÇáãáİÇÊ
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáãáİÇÊ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.sticker_ and mute_sticker == "??" then --Şİá ÇáãáÕŞÇÊ
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáãáÕŞÇÊ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.animation_ and mute_gif == "??" then -- Şİá ÇáãÊÍÑßå
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáÕæÑ ÇáãÊÍÑßå  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.contact_ and mute_contact == "??" then -- Şİá ÇáÌåÇÊ
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÌåÇÊ ÇáÇÊÕÇá  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.location_ and mute_location == "??" then -- Şİá ÇáãæŞÚ
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáãæŞÚ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.voice_ and mute_voice == "??" then -- Şİá ÇáÈÕãÇÊ
del_msg(chat, tonumber(msg.id))
 if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáÈÕãÇÊ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end

elseif msg.game_ and mute_game == "??" then -- Şİá ÇáÇáÚÇÈ
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ áÚÈ ÇáÇáÚÇÈ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.audio_ and mute_audio == "??" then -- Şİá ÇáÕæÊ
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ããäæÚ ÇÑÓÇá ÇáÕæÑ  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end


elseif msg.content_ and msg.reply_markup_ and  msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" and mute_keyboard == "??" then -- ßíÈæÑÏ
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ÚĞÑÇ ÇáßíÈæÑÏ ãŞİæá  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end

elseif msg.content_.entities_ and msg.content_.entities_[0] then


if msg.content_.entities_[0].ID == "MessageEntityBold" or msg.content_.entities_[0].ID == "MessageEntityCode" or msg.content_.entities_[0].ID == "MessageEntityPre" or msg.content_.entities_[0].ID == "MessageEntityItalic" then
del_msg(chat, tonumber(msg.id))
if lock_woring == "??" then
local msgx = "??ããäæÚ ÇÑÓÇá ÇáãÇÑßÏæÇä  ??????"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>?? ÇáÇÓã ? :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>?? ÇáÇíÏí ? :</b> <code>'..msg.from.id..'</code>\n<b>?? ÇáãÚÑİ ? :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
end


end
end
end
end




return {
	patterns = {},
	pre_process = pre_process
}
--End msg_checks.lua--