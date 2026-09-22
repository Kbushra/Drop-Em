print("maps created");

enum MAPS 
{
	CAVES,
	LEN
}

global.maps[MAPS.CAVES] = new map("CAVES", bg_cave, rm_cave_tutorial,
[
	new photo(spr_cave_core, "CORE", rm_cave_core)
]);