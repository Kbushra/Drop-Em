draw_self();
draw_sprite(sprite, 0, x + 3, y + 4);

setup_text(fnt_default, c_black, fa_middle, fa_center, 1);
draw_text(x + sprite_width/2, y + 48, caption);
draw_reset();