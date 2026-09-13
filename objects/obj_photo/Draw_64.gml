draw_self();
draw_sprite(sprite, 0, x, y - 12);

setup_text(fnt_default, c_black, fa_middle, fa_center, 1);
draw_text(x, y + 20, caption);
draw_reset();