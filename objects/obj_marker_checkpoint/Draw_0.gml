glow_alpha = lerp_delta(glow_alpha, glow_client[obj_connection.client_id] ? 0.5 : 0, 0.99);

draw_set_alpha(glow_alpha);
draw_sprite(spr_checkpoint_glow, 0, x, y);
draw_set_alpha(1);

draw_self();