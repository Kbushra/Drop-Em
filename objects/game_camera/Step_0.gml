if keyboard_check_pressed(vk_f4)
{
	window_set_size(GAME_WIDTH * RENDER_SCALE, GAME_HEIGHT * RENDER_SCALE);
	window_set_fullscreen(!window_get_fullscreen());
	window_center();
}

if custom { exit; }

if got_place_signal("goto_spawn")
{
	x = cam_target.x;
	y = cam_target.y;
	xstart = x;
	ystart = y;
	
	cam_clamp();
	cam_set();
	exit;
}

default_behaviour();