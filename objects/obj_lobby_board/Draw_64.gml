draw_self();

code_element.inst.x = bbox_left + 1;
code_element.target(bbox_top + 1);

if !instance_exists(obj_client) { exit; }

var join_codes = array_map(obj_client.hosts, function(el) { return el.join_code; });
if !array_equals(prev_join_codes, join_codes)
{
	prev_join_codes = join_codes;
	update_text();
}

var top = bbox_top + 2 + code_element.height();
for (var i = 0; i < array_length(text); i++)
{
	if !instance_exists(text[i]) { continue; }
	
	var host_photo = get_data_level(obj_client.hosts[i]);
	if host_photo == noone { continue; }
	
	draw_sprite(host_photo.vars.sprite, 0, bbox_left + 1, top - 2);
	text[i].ystart = top;
	top += string_height(text[i].text);
}