instance_create_depth(x, y, depth, obj_connection, { create_object: obj_client });

image_xscale = 1.5;

code_element = new type_box(6, "JOIN CODE", [], function(inst)
{
	if string_length(inst.typed_string) != 6
	{
		with obj_logs { array_push(logs, "ERROR: Join code must be 6 chars long!"); }
		exit;
	}
	
	if !instance_exists(obj_client)
	{
		with obj_logs { array_push(logs, "ERROR: Not connected to server. Try again."); }
		exit;
	}
	
	with obj_logs { array_push(logs, "Using a join code..."); }
	network_send_struct(obj_client.wss, NETWORK_TYPES.JOIN,
	{
		join_code: inst.typed_string,
		player_name: global.save.player_name
	});
});
code_element.create(bbox_left + 1, bbox_top + 1);
code_element.inst.depth = depth - 1;

prev_join_codes = [];
text = [];

event_user(0);