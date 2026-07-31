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
		variable_instance_set(target, names[i], struct[$ names[i]]);
	}
}