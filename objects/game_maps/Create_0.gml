print("maps created");

enum MAPS 
{
	CAVES,
	TEST_CAVES,
	LEN
}

global.maps[MAPS.CAVES] = new map("Caves", bg_cave, rm_cave_tutorial,
[
	new photo(spr_cave_core, "Core", rm_cave_core),
	new photo(spr_cave_core, "Core", rm_cave_core),
	new photo(spr_cave_core, "Core", rm_cave_core)
]);

global.maps[MAPS.TEST_CAVES] = new map("Test caves", spr_checkpoint, rm_cave_tutorial,
[
	new photo(spr_cave_core, "Core", rm_cave_core),
	new photo(spr_cave_core, "Core", rm_cave_core),
	new photo(spr_cave_core, "Core", rm_cave_core)
]);

global.curr_map = global.maps[MAPS.CAVES];