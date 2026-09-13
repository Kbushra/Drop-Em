elements = array_create_ext(MAPS.LEN, function(ind)
{ return new text_container($"{global.maps[ind].name}:", empty, false); });

array_insert(elements, 0, new tab("BACK", function()
{
	close = true;
	for (var i = 0; i < MAPS.LEN; i++) { lists[i].close = true; }
	instance_create_depth(x, y, depth, obj_list_host);
}));

event_inherited();

for (var i = 0; i < MAPS.LEN; i++)
{
	lists[i] = instance_create_depth(x + string_width($"{global.maps[i].name}:") + 5, y + yoffsets[i + 1] + 16, depth,
		obj_list_horizontal, { elements: global.maps[i].level_photos });
}