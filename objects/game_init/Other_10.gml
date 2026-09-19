///@func init_game()
init_game = function()
{
	instance_create_unique(x, y, depth, game_maps);
	
	instance_create_unique(x, y, depth, game_saver);
	
	instance_create_unique(x, y, depth, game_input);
	instance_create_unique(x, y, depth, game_camera);
	instance_create_unique(x, y, depth, game_audio);
	
	instance_create_unique(x, y, depth, game_debug);
}