var player = PLAYER;
if instance_exists(player) { hp = player.hp; }

draw_text(16, 16 + string_height("A"), $"HP: {hp}\nSCORE: {round(global.score)}");
if instance_exists(obj_client) && !instance_exists(obj_lava)
{
	draw_set_halign(fa_center);
	draw_text(room_width/2, 16, $"Awaiting host...\n({CLIENTS_REMAINING + 1}/8)");
	draw_set_halign(fa_left);
}