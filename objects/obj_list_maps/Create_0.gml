back = function()
{
	close = true;
	instance_create_depth(x, y, depth, obj_list_main);
};

elements[0] = new tab("BACK", back);

for (var i = 0; i < array_length(global.maps); i++)
{
	array_push(elements, new tab(global.maps[i].name, method({ id, i }, function()
	{
		global.save.map_index = i;
		json_save();
		id.back();
	})));
}

event_inherited();