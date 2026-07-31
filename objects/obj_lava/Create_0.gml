calculate_id();

x = room_width/2;
y = room_height + sprite_height;
spd = 32;
level = 0;

with (obj_player)
{
	agile = true;
	last_checkpoint_time = current_time;
}

///@func colliding(x, y)
colliding = function(_x, _y) { return place_meeting(x, y + 30, other); }