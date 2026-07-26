function empty() {}

function buffer_struct(struct)
{
	var text = json_stringify(struct);
	var buff = buffer_create(string_length(text) + 1, buffer_fixed, 1);
	buffer_write(buff, buffer_string, text);
	
	return { buffer: buff, len: string_length(text) };
}

function get_object_data(extra = {})
{
	var data =
	{
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
		
	var extra_names = struct_get_names(extra);
	for (var i = 0; i < array_length(extra_names); i++)
	{
		data[$ extra_names[i]] = extra[$ extra_names[i]];
	}
		
	return data;
}

function apply_struct(target, struct)
{
	var names = struct_get_names(struct);
	for (var i = 0; i < array_length(names); i++)
	{
		variable_instance_set(target, names[i], struct[$ names[i]]);
	}
}