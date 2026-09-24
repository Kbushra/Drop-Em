if !instance_exists(PLAYER) { image_index = 0; exit; }

depth = PLAYER.depth + 1;
image_index = place_meeting(x, y, PLAYER);
if image_index == 1 && game_input.input_pressed[KEY.DOWN]
{
	instance_destroy(PLAYER);
}