image_alpha = 0;
if image_xscale == 0 { image_xscale = string_width(text); }
if image_yscale == 0 { image_yscale = string_height(text); }

///@func get_coord()
get_coord = function()
{
	var coord = new coordinate(x, y);
	switch xalign
	{
		case fa_center: case fa_middle:
			coord.x -= sprite_width/2;
		break;
	
		case fa_right:
			coord.x -= sprite_width;
		break;
	}

	switch yalign
	{
		case fa_center: case fa_middle:
			coord.y -= sprite_height/2;
		break;
	
		case fa_bottom:
			coord.y -= sprite_height;
		break;
	}
	
	return coord;
}