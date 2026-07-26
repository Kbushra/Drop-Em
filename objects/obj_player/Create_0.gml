if !instance_exists(obj_server) { instance_destroy(); }

enum PLAYER_STATES
{
	WALK,
	JUMP
}

x = obj_player_spawn.x;
y = obj_player_spawn.y;
hsp = 0;
vsp = 0;

state = PLAYER_STATES.WALK;

event_user(0);