if !assert(instance_exists(obj_player_spawn), "No player spawn!") { exit; }

x = obj_player_spawn.x;
y = obj_player_spawn.y;
xstart = x;
ystart = y;
hsp = 0;
vsp = 0;

last_checkpoint_time = current_time;
arena_place = 0;
current_arena = noone;