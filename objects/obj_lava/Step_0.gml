default_receive_data();

if !instance_exists(obj_server) { exit; }

var nine_slice_height = 50;
var height = sprite_get_height(sprite_index);

var min_dist = NONE;
with obj_player
{
	if hp <= 0 { continue; }
	if other.bbox_top - y < min_dist || min_dist == NONE { min_dist = other.bbox_top - y; }
}

level += spd * DELTA;

depth = -100;
image_yscale = (height - nine_slice_height)/height + level/nine_slice_height;
image_alpha = 0.8;

spd = lerp_delta(spd, min_dist > 120 ? 128 : 32, 0.995);

write_data(true);