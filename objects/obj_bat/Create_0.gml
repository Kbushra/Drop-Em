event_inherited();
event_user(0);
event_user(1);

enum BAT_STATES
{
	WALK,
	JUMP,
	FALL,
	SLIDE,
	WALL,
	WALL_JUMP,
	GLIDE,
	KNOCKBACK
}

slow_spd = 120;
spd = 180;
slide_spd = 270;
glide_spd = 270;
jump_force = -6;
wall_force = -450;
up_grv = 15;
down_grv = 25;
knockback_h_force = 240;
knockback_v_force = -6;

state = BAT_STATES.WALK;
slide_dir = 0;
glide_dir = 0;
current_wall_force = 0;
wall_dir = 0; //Side the wall is on relative to player
knockback_delay = 0;
current_knockback_h_force = 0;
current_knockback_v_force = 0;

attacking = false;
attack_cooldown = 0;
inv_frames = 0;

coyote_press_up = 0;
coyote_press_down = 0;
coyote_fall = 0;
coyote_wall_stick = 0;