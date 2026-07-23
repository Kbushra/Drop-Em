draw_self();

draw_set_halign(fa_center);
draw_text_ext(x, bbox_top + 100, $"Note: This game uses no external servers, so if you intend to use the global join code rather than play in your LAN, you must port forward {PORT} as TCP/UDP.", 28, 500);
draw_set_halign(fa_left);