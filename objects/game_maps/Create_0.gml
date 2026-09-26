print("maps created");

enum MAPS 
{
	CAVES,
	MORE_CAVES,
	LEN
}

global.maps[MAPS.CAVES] = new map("CAVES", bg_cave, rm_cave_tutorial,
[
	new photo(spr_cave_core, "CORE", rm_cave_core),
	new photo(spr_cave_exit, "TUT", rm_cave_tutorial)
]);

global.maps[MAPS.MORE_CAVES] = new map("CAVES+", spr_bat_idle, rm_cave_tutorial,
[
	new photo(spr_cave_exit, "TUT", rm_cave_tutorial),
	new photo(spr_cave_core, "CORE", rm_cave_core)
]);