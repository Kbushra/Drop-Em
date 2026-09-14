if array_length(elements) == 0 { instance_destroy(); exit; }

event_user(0);

close_timer = 0;
width = 0;
height = 0;

spawn_element(noone, elements[0], 0);
array_reduce(elements, spawn_element);
calculate_dimensions();