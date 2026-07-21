///@func cam_set()
cam_set = function()
{
	cam_set_zoom_offsets();
	cam_clamp();
	
	var x_shake = random_range(-shake_intensity, shake_intensity);
	var y_shake = random_range(-shake_intensity, shake_intensity);
	shake_intensity = 0;
	
	camera_set_view_size(VIEW, width / zoom, height / zoom);
	camera_set_view_pos(VIEW, x - xoffset_zoom, y - yoffset_zoom);
}

///@func cam_dimensions()
cam_dimensions = function()
{
	var prev_x_offset = xoffset;
	var prev_y_offset = yoffset;
	
	width = GAME_WIDTH;
	height = GAME_HEIGHT;
	scale = 1;
	display_set_gui_size(width / scale, height / scale);
	surface_resize(application_surface, width * RENDER_SCALE, height * RENDER_SCALE);
	
	xoffset = width/2;
	yoffset = height/2;
	
	x += (xoffset - prev_x_offset) / 2;
	y += (yoffset - prev_y_offset) / 2;
}

///@func cam_set_target()
cam_set_target = function(_target)
{
	if !instance_exists(_target) { return; }
	
	x = _target.x;
	y = _target.y;
}

///@func cam_set_zoom_offsets()
cam_set_zoom_offsets = function()
{
	xoffset_zoom = xoffset - (zoom - 1) * (xoffset / zoom);
	yoffset_zoom = yoffset - (zoom - 1) * (yoffset / zoom);
}

///@func cam_clamp()
cam_clamp = function()
{
	x = clamp(x, xoffset_zoom, room_width - xoffset_zoom);
	y = clamp(y, yoffset_zoom, room_height - yoffset_zoom);
}

///@func default_behaviour()
default_behaviour = function()
{
	cam_dimensions();
	if (instance_exists(cam_target))
		cam_set_target(cam_target);

	cam_set();
}

///@func set_shake(shake)
set_shake = function(shake)
{
	if shake <= shake_intensity { return; }
	shake_intensity = shake;
}

///@func fit_room()
fit_room = function()
{
	custom = true;

	width = room_width;
	height = room_height;
	x = 0;
	y = 0;
	display_set_gui_size(room_width, room_height);
	surface_resize(application_surface, room_width, room_height);

	zoom = 1;
	xoffset = 0;
	yoffset = 0;
	cam_set();
}

/// @func cam_create()
cam_create = function ()
{
	if !view_get_visible(VIEW) { view_set_visible(VIEW, true); }
	
	camera_set_view_size(VIEW, width / zoom, height / zoom);
	view_set_wport(VIEW_NUMBER, GAME_WIDTH * RENDER_SCALE);
	view_set_hport(VIEW_NUMBER, GAME_HEIGHT * RENDER_SCALE);
}