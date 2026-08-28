for (var i = array_length(reached_player); i < CLIENT_COUNT + 1; i++)
{
	reached_player[i] = false;
	glow_player[i] = false;
}

for (var i = 0; i < array_length(glow_player); i++) { glow_player[i] = glow_for_player(i - 1); }

glow_alpha = lerp_delta(glow_alpha, glow_player[CLIENT_ID + 1] ? 0.5 : 0, 0.99);