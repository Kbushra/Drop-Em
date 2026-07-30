event_inherited();

var lava_level = room_height - lava_top - 48;
if (arena_started && (!arena_ended || obj_lava.level < lava_level - 1))
{
	obj_lava.spd = 0;
	obj_lava.level = lerp_delta(obj_lava.level, lava_level, 0.995);
}