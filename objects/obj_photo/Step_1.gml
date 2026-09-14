array_push(obj_mouse.clickables, id);

var focused = got_signal("pressed") && !got_signal("disable");
y = lerp_delta(y, focused ? targ_y - 10 : targ_y, 0.995);