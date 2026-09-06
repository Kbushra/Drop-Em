function element(_obj, _gap = 0) constructor
{
	gap = _gap;
	targ_y = 0;
	inst = noone;
	
	obj = _obj;
	vars = {};
	
	static create = function(y)
	{
		inst = instance_create_depth(0, y, 0, obj, vars);
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

function button(name, func): element(obj_button) constructor
{
	vars = { name, func };
}

function type_box(limit, placeholder, special_chars, func): element(obj_type_box, 8) constructor
{
	vars = { limit, placeholder, special_chars, func };
}