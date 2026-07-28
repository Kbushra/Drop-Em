event_inherited();

if input_pressed[KEY.UP] { coyote_press_up = 0.2; }
if input_pressed[KEY.DOWN] { coyote_press_down = 0.2; }

state_transition();
state_step();

coyote_press_up -= DELTA;
coyote_press_down -= DELTA;
coyote_fall -= DELTA;

x += hsp;
y += vsp;
if hsp != 0 { image_xscale = sign(hsp); }