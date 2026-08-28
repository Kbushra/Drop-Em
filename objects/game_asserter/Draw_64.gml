if keyboard_check_pressed(vk_f4) { window_set_fullscreen(!window_get_fullscreen()); }

draw_set_colour(c_black);
draw_rectangle(0, 0, GUI_W, GUI_H, false);
draw_set_colour(c_white);

draw_set_halign(fa_middle);
draw_set_valign(fa_center);

draw_text(GAME_WIDTH/2, 90, "(BUG REPORT THIS)\nError!");

draw_set_colour(severe ? c_red : c_white);
draw_text(GAME_WIDTH/2, 150, desc);
draw_set_colour(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);