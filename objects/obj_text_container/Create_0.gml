image_alpha = 0;
if image_xscale == 0 { image_xscale = string_width(text); }
if image_yscale == 0 { image_yscale = string_height(text); }

///@func update_coord()
update_coord = function()
{
	xstart = x;
	ystart = y;
	
	switch xalign
	{
		case fa_center: case fa_middle:
			x -= sprite_width/2;
		break;
	
		case fa_right:
			x -= sprite_width;
		break;
	}

	switch yalign
	{
		case fa_center: case fa_middle:
			y -= sprite_height/2;
		break;
	
		case fa_bottom:
			y -= sprite_height;
		break;
	}
}

update_coord();