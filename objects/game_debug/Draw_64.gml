draw_reset();

draw_set_alpha(0.5 * show_help_text);
draw_set_halign(fa_right);
draw_text_transformed(GAME_WIDTH - 5, 4,
@"
Debugging!
ALT+A to toggle audio log
CTRL+Q to slow the game down
CTRL+F to save
CTRL+T to toggle controlling all players on host end
CTRL+U to toggle activation
CTRL+D to toggle debug overlay
",
0.5, 0.5, 0);

draw_reset();