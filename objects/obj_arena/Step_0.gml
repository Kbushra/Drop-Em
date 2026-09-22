var disable_starting = false;
for (var i = 0; i < array_length(entrances); i++)
{
	entrances[i].open = !arena_started;
	if entrances[i].blocked() { disable_starting = true; }
}

for (var i = 0; i < array_length(exits); i++) { exits[i].open = arena_ended; }

if !arena_started && !arena_ended && !disable_starting
{
	arena_started = true;
	
	var alive_players = 0;
	with obj_player { if hp > 0 { alive_players++; } }
	
	with obj_player
	{
		if hp <= 0 && alive_players > 0 { continue; }
		
		for (var i = 0; i < array_length(other.triggers); i++)
		{
			var trig = other.triggers[i]
			if rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom,
			trig.bbox_left, trig.bbox_top, trig.bbox_right, trig.bbox_bottom) != 1
			{ other.arena_started = false; }
		}
	}
	
	if arena_started
	{
		available_place = 0;
		with obj_player
		{
			current_arena = other.id;
			if hp > 0 { arena_place = 1; other.available_place++; }
			else { arena_place = 0; }
		}
	}
}

if arena_started && !arena_ended
{
	var alive_players = 0;
	with obj_player { if hp > 0 { alive_players++; } }
	
	if alive_players <= 1
	{
		arena_ended = true;
		
		with obj_player
		{
			switch arena_place
			{
				case 3: _score += 25; break;
				case 2: _score += 75; break;
				case 1: _score += 250; break;
			}
			
			current_arena = noone;
			arena_place = 0;
		}
	}
}