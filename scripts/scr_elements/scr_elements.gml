function element(_obj, _gap = 0) constructor
{
	gap = _gap;
	targ_y = 0;
	inst = noone;
	
	obj = _obj;
	vars = {};
	
	static create = function(x, y)
	{
		if object_exists(obj) { inst = instance_create_depth(x, y, 0, obj, vars); }
		target(y);
		return self;
	}
	
	static disable = function()
	{
		if !instance_exists(inst) { return self; }
		send_signal(inst, "disable");
		return self;
	}
	
	static target = function(y)
	{
		targ_y = y;
		if instance_exists(inst) { inst.targ_y = y; }
		return self;
	}
	
	static width = function() { return instance_exists(inst) ? inst.sprite_width : 0; }
	static height = function() { return instance_exists(inst) ? inst.sprite_height : 0; }
}

//Divide by 2 because gap does padding on both sides
function empty_space(_gap): element(noone, _gap/2) constructor {}

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
}

function photo(sprite, caption, room): element(obj_photo, 12) constructor
{
	vars = { sprite, caption, _room: room };
}

//Not an element but needs photo
function map(_name, _bg, _tutorial_room, _level_photos) constructor
{
	name = _name;
	bg = _bg;
	tutorial_room = _tutorial_room;
	level_photos = _level_photos;
}