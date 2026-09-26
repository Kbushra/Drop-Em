if global.save.player_name != name_box.inst.typed_string
{
	global.save.player_name = name_box.inst.typed_string;
	json_save();
}