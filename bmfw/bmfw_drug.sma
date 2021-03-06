#include <bmfw>

#define	PLUGIN_NAME	"BM Bunny Hop"
#define	PLUGIN_AUTHOR	"JoRoPiTo"
#define	PLUGIN_VERSION	"0.1"

#define BM_FOV		180
#define BM_DEFAULTFOV	90
#define BM_COOLDOWN	30.0

new const g_Name[] = "Drug"
new const g_Model[] = "drug"

new const Float:g_Size[4] = { 64.0, 64.0, 8.0 }
new const Float:g_SizeSmall[4] = { 16.0, 16.0, 8.0 }
new const Float:g_SizeLarge[4] = { 128.0, 128.0, 8.0 }

new g_SetFOV

public plugin_init()
{
	register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR)
	_reg_block(g_Name, PLUGIN_VERSION, g_Model, TOUCH_FOOT, BM_COOLDOWN, g_Size, g_SizeSmall, g_SizeLarge)
	g_SetFOV = get_user_msgid("SetFOV")

}

public plugin_precache()
{
	bm_precache_model("%s%s.mdl", BM_BASEFILE, g_Model)
	bm_precache_model("%s%s_large.mdl", BM_BASEFILE, g_Model)
	bm_precache_model("%s%s_small.mdl", BM_BASEFILE, g_Model)
}

public block_Touch(touched, toucher)
{
	message_begin(MSG_ONE, g_SetFOV, {0, 0, 0}, toucher)
	write_byte(BM_FOV)
	message_end()
	set_task(30.0, "player_undrug", toucher)
	return PLUGIN_CONTINUE
}

public player_undrug(id)
{
	message_begin(MSG_ONE, g_SetFOV, {0, 0, 0}, id)
	write_byte(BM_DEFAULTFOV)
	message_end()
}
