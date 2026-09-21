event_inherited();

slide_spd = 270;
glide_spd = 270;
jump_force = -6;
wall_force = -450;

slide_dir = 0;
glide_dir = 0;
current_wall_force = 0;
wall_dir = 0; //Side the wall is on relative to player

coyote_press_up = 0;
coyote_press_down = 0;
coyote_fall = 0;
coyote_wall_stick = 0;

lowest_y = ystart;

last_checkpoint = noone;
revive_xstart = xstart;
revive_ystart = ystart;
revive_time = 0;

attack_sprite = spr_bat_attack;
attack_mask = spr_bat_mask_attack;