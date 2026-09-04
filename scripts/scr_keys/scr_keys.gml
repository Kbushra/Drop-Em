enum KEY
{
	UP,
	DOWN,
	LEFT,
	RIGHT,
	SPECIAL,
	ATTACK,
	PAUSE,
	COUNT
}

enum KEY_STATE
{
	PRESSED,
	HELD,
	RELEASED
}

function default_inputs()
{
	var arr = [];
	for (var i = 0; i < KEY.COUNT; i++)
	{
		arr[i] = false;
	}
	return arr;
}

function default_input_data()
{
	return
	{
		input_pressed: default_inputs(),
		input_held: default_inputs(),
		input_released: default_inputs(),
		delta: 0
	};
}

function key_check_direct(key, state)
{
	switch (state)
	{
		case KEY_STATE.PRESSED:
		if key == KEY.UP && keyboard_check_pressed(vk_space) { return true; }
		return keyboard_check_pressed(global.config.keyboard_bind[key][0]) ||
			keyboard_check_pressed(global.config.keyboard_bind[key][1]);
		
		case KEY_STATE.HELD:
		if key == KEY.UP && keyboard_check(vk_space) { return true; }
		return keyboard_check(global.config.keyboard_bind[key][0]) ||
			keyboard_check(global.config.keyboard_bind[key][1]);
		
		case KEY_STATE.RELEASED:
		if key == KEY.UP && keyboard_check_released(vk_space) { return true; }
		return keyboard_check_released(global.config.keyboard_bind[key][0]) ||
			keyboard_check_released(global.config.keyboard_bind[key][1]);
	}
	
	return false;
}