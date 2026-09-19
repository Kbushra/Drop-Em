print("maps created");

enum MAPS 
{
	CAVES,
	LEN
}

global.maps[MAPS.CAVES] = new map("Caves", bg_cave, rm_cave_tutorial,
[
	new photo(spr_cave_core, "Core", rm_cave_core)
]);