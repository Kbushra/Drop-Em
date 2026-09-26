default_id($"player{client_id}");

if client_id == CLIENT_ID
{
	global.score = 0;
	instance_create_unique(x, y, depth, obj_player_follower, { player: id });
	instance_create_unique(x, y, depth, obj_stats);
	if instance_exists(obj_host) { instance_create_unique(x, y, depth, obj_host_info); }
}

event_user(0);
event_user(1);
event_user(2);

hsp = 0;
vsp = 0;
positions = {};

slow_spd = 120;
spd = 180;
up_grv = 15;
down_grv = 25;

knockback_delay = 0;
knockback_h_force = 240;
knockback_v_force = -6;
current_knockback_h_force = 0;
current_knockback_v_force = 0;

last_checkpoint_time = current_time;
arena_place = 0;
current_arena = noone;

input_pressed = default_inputs();
input_held = default_inputs();
input_released = default_inputs();
delta = 0;

attacking = false;
attack_sprite = noone;
attack_mask = noone;
attack_cooldown = 0;
inv_frames = 0;

spawn_end_screen = false;