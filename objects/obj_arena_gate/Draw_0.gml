image_xscale = open ? 0 : 1;
sprite_xscale = lerp_delta(sprite_xscale, image_xscale, 0.99);
draw_sprite_ext(sprite_index, image_index, x, y, sprite_xscale, image_yscale,
	image_angle, image_blend, image_alpha);

obj_server.write_data({ sprite_xscale });