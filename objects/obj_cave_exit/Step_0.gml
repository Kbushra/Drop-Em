if !instance_exists(PLAYER) { image_index = 0; exit; }

depth = 10;
image_index = !PLAYER.state.state_is("ghost") && PLAYER.visible && place_meeting(x, y, PLAYER);