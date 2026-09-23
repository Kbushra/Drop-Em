draw_self();

var prev_scissor = gpu_get_scissor();
var new_scissor = gui_to_window(bbox_left, bbox_top, bbox_right - bbox_left, bbox_bottom - bbox_top);

gpu_set_scissor(new_scissor);
draw_set_font(fnt_small);
log_data(true);
draw_set_font(fnt_default);
gpu_set_scissor(prev_scissor);