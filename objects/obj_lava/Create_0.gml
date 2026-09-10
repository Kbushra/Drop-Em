calculate_id();

with obj_host { joinable = false; }

x = room_width/2;
y = room_height + sprite_height;
spd = 32;
level = 0;

with (obj_player)
{
	agile = true;
	last_checkpoint_time = current_time;
}

///@func colliding([yoffset])
colliding = function(yoffset = 0) { return place_meeting(x, y + yoffset + 30, other); }