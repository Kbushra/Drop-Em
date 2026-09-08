for (var _y = 0; _y < GUI_H; _y += sprite_get_height(pause_sprite))
{
	for (var _x = 0; _x < GUI_W; _x += sprite_get_width(pause_sprite))
	{
		draw_sprite(pause_sprite, 0, _x, _y);
	}
}

setup_text(fnt_default, c_black, fa_middle, fa_center, 1);
draw_text(GUI_W/2, GUI_H/2, "WAITING FOR HOST...");