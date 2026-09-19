draw_sprite_ext(sprite_index, 0, x, targ_y, 1, 1, 0, c_white, 0.2);

draw_self();
draw_sprite(sprite, 0, x + 3, y + 4);

setup_text(fnt_small, c_black, fa_middle, fa_center, 1);
draw_text_ext(x + sprite_width/2, y + 48, caption, 5, sprite_width);
draw_reset();