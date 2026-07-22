if !got_signal("pressed") { exit; }

clipboard_set_text(obj_server.join_code);
instance_destroy();