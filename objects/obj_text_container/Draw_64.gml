var coord = get_coord();
draw_self_pos(coord.x, coord.y);

setup_text(fnt_default, c_white, halign, valign, 1);
draw_text(x + padding_x, y + padding_y, text);
draw_reset();