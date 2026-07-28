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
	GLIDE
}

slow_spd = 120;
spd = 180;
slide_spd = 270;
glide_spd = 270;
jump_force = -6;
wall_force = -450;
up_grv = 15;
down_grv = 25;

state = BAT_STATES.WALK;
initial_slide_dir = 0;
initial_glide_dir = 0;
current_wall_force = 0;
wall_dir = 0; //Side the wall is on relative to player

coyote_press_up = 0;
coyote_press_down = 0;
coyote_fall = 0;
coyote_wall_stick = 0;