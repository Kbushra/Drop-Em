event_inherited();

enum BAT_STATES
{
	WALK,
	JUMP,
	FALL,
	SLIDE,
	WALL,
	WALL_JUMP,
	GLIDE,
	KNOCKBACK,
	GHOST
}

slide_spd = 270;
glide_spd = 270;
jump_force = -6;
wall_force = -450;

state = BAT_STATES.WALK;
knockback_state = BAT_STATES.KNOCKBACK;
ghost_state = BAT_STATES.GHOST;

slide_dir = 0;
glide_dir = 0;
current_wall_force = 0;
wall_dir = 0; //Side the wall is on relative to player

coyote_press_up = 0;
coyote_press_down = 0;
coyote_fall = 0;
coyote_wall_stick = 0;

lava_grace = 0;
lowest_y = ystart;

attack_sprite = spr_bat_attack;
attack_mask = spr_bat_mask_attack;