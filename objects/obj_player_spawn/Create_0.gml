if !instance_exists(CONNECTOR)
	{ instance_create_depth(x, y, depth, obj, { agile }); exit; }

if !instance_exists(obj_host) { exit; }

for (var i = -1; i < CLIENT_COUNT; i++)
{
	if i >= 0 && obj_host.input_data[i] == -1 { continue; }
	instance_create_depth(x, y, depth, obj, { client_id: i, agile });
}