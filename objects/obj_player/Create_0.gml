if !assert(instance_exists(obj_player_spawn), "No player spawn!") { exit; }
calculate_id();

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

input_pressed = inputs_default();
input_held = inputs_default();
input_released = inputs_default();
delta = 0;