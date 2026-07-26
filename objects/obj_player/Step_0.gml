depth = 0;

input_pressed = obj_server.clients[client_id].frame_inputs.input_pressed;
input_held = obj_server.clients[client_id].frame_inputs.input_held;
input_released = obj_server.clients[client_id].frame_inputs.input_released;

switch state
{
	case PLAYER_STATES.WALK:
		update_hsp();
		update_vsp();
		if !place_free(x, y + 1)
		{
			vsp = 0;
			if input_pressed[KEY.UP] { vsp = -5; state = PLAYER_STATES.JUMP; }
		}

		collide();
	break;
	
	case PLAYER_STATES.JUMP:
		update_hsp();
		update_vsp();
		if input_released[KEY.UP] || vsp >= 0 { vsp = 0; state = PLAYER_STATES.WALK; }
	
		collide();
	break;
}

x += hsp;
y += vsp;

if hsp != 0
{
	sprite_index = spr_bat_walk;
	image_xscale = sign(hsp);
}
else { sprite_index = spr_bat_idle; }

obj_server.write_data({ client_id });