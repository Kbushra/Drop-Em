image_xscale = 1.5;

code_element = new type_box(6, "JOIN CODE", [], function(inst)
{
	if string_length(inst.typed_string) != 6 || !instance_exists(obj_client) { exit; }
	network_send_struct(obj_client.wss, NETWORK_TYPES.JOIN, { join_code: inst.typed_string });
});
code_element.create(bbox_left + 1, bbox_top + 1);
code_element.inst.depth = depth - 1;

prev_join_codes = [];
text = [];