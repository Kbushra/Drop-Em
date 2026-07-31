for (var i = array_length(reached_client); i < CLIENT_COUNT; i++)
{
	reached_client[i] = false;
	glow_client[i] = false;
}

for (var i = 0; i < array_length(glow_client); i++) { glow_client[i] = glow_for_player(i); }

glow_alpha = lerp_delta(glow_alpha, glow_client[CLIENT_ID] ? 0.5 : 0, 0.99);

draw_set_alpha(glow_alpha);
draw_sprite(spr_checkpoint_glow, 0, x, y);
draw_set_alpha(1);

draw_self();