///@desc Methods

///@func get_curr_path()
get_curr_path = function()
{
	var curr_path = full_path;
	for (var i = 0; i < array_length(indices); i++)
	{ curr_path = curr_path[indices[i]].path; }
	
	return curr_path;
}

///@func create_ui()
create_ui = function()
{
	instance_destroy(obj_text_container);
	instance_destroy(obj_type_box);
	instance_destroy(obj_panel);
	instance_destroy(obj_button);
	
	var curr_path = get_curr_path();
	var top = 32;
	var gap = 80;
	for (var i = 0; i < array_length(curr_path); i++)
	{
		curr_path[i][$ "func"] ??= empty;
		curr_path[i][$ "vars"] ??= {};
		curr_path[i].vars.ind = i;
		
		instance_create_depth(32, top + i * gap, depth,
			curr_path[i].obj, curr_path[i].vars);
	}
}