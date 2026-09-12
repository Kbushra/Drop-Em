draw_self();

draw_set_valign(fa_middle);
draw_set_colour(typed_string == "" ? c_grey : c_white);
draw_text(x + 2, y + sprite_height/2, !focused && typed_string == "" ? placeholder : typed_string);
draw_reset();