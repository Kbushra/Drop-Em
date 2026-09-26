draw_self();
draw_text_ext(bbox_left + 2, bbox_top + 2, $"Wow you scored {round(global.score)}!", 20, bbox_right - bbox_left - 4);

var finished = true;
with obj_player { if !spawn_end_screen { finished = false; } }

if instance_exists(obj_host) && finished
{
	if !instance_exists(text)
	{
		text = instance_create_depth(GUI_W/2, bbox_bottom - 2, depth - 1, obj_text_container,
		{
			xalign: fa_middle,
			yalign: fa_bottom,
			halign: fa_middle,
			valign: fa_bottom,
			image_xscale: bbox_right - bbox_left - 4,
			text: "Restart",
			func: function() { transition(room, empty, true); }
		});
	}
	
	text.ystart = bbox_bottom - 2;
}
else
{
	draw_set_valign(fa_bottom);
	draw_text(bbox_left + 2, bbox_bottom - 2, !finished ?
		"Waiting for others..." : "Waiting for host...");
	draw_set_valign(fa_top);
}