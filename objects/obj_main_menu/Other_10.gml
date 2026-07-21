///@desc Methods

///@func get_curr_path()
get_curr_path = function()
{
	var curr_path = full_path;
	for (var i = 0; i < array_length(indices); i++)
	{ curr_path = curr_path[indices[i]].path; }
	
	return curr_path;
}

///@func create_buttons()
create_buttons = function()
{
	instance_destroy(obj_button);
	
	var curr_path = get_curr_path();
	var top = 64;
	var gap = 80;
	for (var i = 0; i < array_length(curr_path); i++)
	{
		instance_create_depth(128, top + i * gap, depth,
			curr_path[i].button, { ind: i, name: curr_path[i].name });
	}
}