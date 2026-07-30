var is_player = object_name == object_get_name(obj_player) ||
	object_get_parent(asset_get_index(object_name)) == obj_player;

if is_player && client_id == obj_connection.client_id
{
	switch_marker(obj_marker_client, { _id, client_id, hp, _score });
	exit;
}

if object_name == object_get_name(obj_checkpoint)
{
	switch_marker(obj_marker_checkpoint, { _id, glow_client });
	exit;
}

if object_name == object_get_name(obj_lava)
{
	switch_marker(obj_marker_lava, { _id });
	exit;
}

if object_name == object_get_name(obj_arena_gate)
{
	switch_marker(obj_marker_arena_gate, { _id, sprite_xscale });
	exit;
}