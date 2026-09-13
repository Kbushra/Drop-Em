function element(_obj, _gap = 0) constructor
{
	gap = _gap;
	targ_y = 0;
	inst = noone;
	
	obj = _obj;
	vars = {};
	
	static create = function(x, y)
	{
		inst = instance_create_depth(x, y, 0, obj, vars);
		return self;
	}
	
	static disable = function()
	{
		if !instance_exists(inst) { return self; }
		send_signal(inst, "disable");
		return self;
	}
	
	static approach = function()
	{
		if !instance_exists(inst) { return self; }
		inst.y = lerp_delta(inst.y, targ_y, 0.995);
		return self;
	}
}

function tab(name, func): element(obj_tab) constructor
{
	vars = { name, func };
}

function type_box(limit, placeholder, special_chars, func): element(obj_type_box, 8) constructor
{
	vars = { limit, placeholder, special_chars, func };
}

function text_container(text, func = empty, clickable = true, width = 0, height = 0, settings = {}):
element(obj_text_container, 0) constructor
{
	vars = { text, func, clickable, image_xscale: width, image_yscale: height };
	vars = struct_concat(vars, settings);
	
	static approach = function()
	{
		if !instance_exists(inst) { return self; }
		inst.ystart = lerp_delta(inst.ystart, targ_y, 0.995);
		return self;
	}
}

function photo(sprite, caption, room): element(obj_photo, -48) constructor
{
	vars = { sprite, caption, _room: room };
}

//Not an element but needs photo
function map(_name, _tutorial_photo, _level_photos) constructor
{
	name = _name;
	tutorial_photo = _tutorial_photo;
	level_photos = _level_photos;
}