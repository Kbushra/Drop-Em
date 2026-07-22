function empty() {}

function buffer_struct(struct)
{
	var text = json_stringify(struct);
	var buff = buffer_create(string_length(text) + 1, buffer_fixed, 1);
	buffer_write(buff, buffer_string, text);
	
	return { buffer: buff, len: string_length(text) };
}