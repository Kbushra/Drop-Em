default_receive_data();

image_xscale = open ? 0 : 1;
sprite_xscale = lerp_delta(sprite_xscale, image_xscale, 0.99);

write_data(false, { open });