function empty() {}

function buffer_struct(struct)
{
	var text = json_stringify(struct);
	var buff = buffer_create(string_length(text) + 1, buffer_fixed, 1);
	buffer_write(buff, buffer_string, text);
	
	return { buffer: buff, len: string_length(text) };
}

function get_object_data()
{
	return
	{
		object_index,
		sprite_index,
		image_index,
		image_alpha,
		image_blend,
		image_xscale,
		image_yscale,
		image_angle,
		visible,
		x,
		y,
		depth,
		layer
	};
}

function write_data(write_defaults, struct = {})
{
	if !instance_exists(obj_server) { return; }
	
	var data = {};
	
	if write_defaults
	{
		data = get_object_data();
		data.sprite_index = sprite_get_name(sprite_index);
		data.layer = layer_get_type(layer) == layer_type_unknown ? "" : layer_get_name(layer);
	}
	
	data.object_index = object_get_name(object_index);
	data = struct_concat(data, struct);
	obj_server.object_data[$ calculate_id()] = data;
}

function default_receive_data()
{
	if !got_signal("received_data") { return; }
	
	apply_struct(id, obj_connection.object_data[$ instance]);
	stop_signal("received_data");
}

function struct_concat(struct1, struct2)
{
	struct1 = variable_clone(struct1, 0);
	
	var names = struct_get_names(struct2);
	for (var i = 0; i < array_length(names); i++)
	{
		struct1[$ names[i]] = struct2[$ names[i]];
	}
		
	return struct1;
}

function apply_struct(target, struct)
{
	var names = struct_get_names(struct);
	for (var i = 0; i < array_length(names); i++)
	{
		try { variable_instance_set(target, names[i], struct[$ names[i]]); }
		catch(readonly) {}
	}
}