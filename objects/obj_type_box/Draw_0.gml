draw_self();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(typed_string == "" ? c_grey : c_white);
draw_text(x, y, typed_string == "" ? placeholder : typed_string);
draw_reset();