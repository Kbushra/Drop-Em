///@desc Toggle activation
if !keyboard_check(vk_control) { exit; }

if instance_count == 1 { instance_activate_all(); }
else { instance_deactivate_all(true); }