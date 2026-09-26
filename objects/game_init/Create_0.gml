randomize();
draw_set_font(fnt_default);

network_set_config(network_config_connect_timeout, 2000);

event_user(0);
init_game();

global.score = 0;

room_goto(rm_main);
instance_destroy();