print("camera created");

image_alpha = 0;

width = GAME_WIDTH;
height = GAME_HEIGHT;
scale = 1;
display_set_gui_size(width / scale, height / scale);

xoffset = width / 2;
yoffset = height / 2;
zoom = 1;

cam_target = obj_host;

custom = false;
shake_intensity = 0;

event_user(0);

cam_create();
cam_set();

window_set_size(GAME_WIDTH * RENDER_SCALE, GAME_HEIGHT * RENDER_SCALE);
window_center();