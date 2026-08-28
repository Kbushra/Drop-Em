if !assert(instance_exists(obj_player_spawn), "No player spawn!") { exit; }
set_id($"player{client_id}");

x = obj_player_spawn.x;
y = obj_player_spawn.y;
xstart = x;
ystart = y;
hsp = 0;
vsp = 0;

state = BAT_STATES.WALK;

last_checkpoint_time = current_time;
arena_place = 0;
current_arena = noone;

input_pressed = default_inputs();
input_held = default_inputs();
input_released = default_inputs();
delta = 0;