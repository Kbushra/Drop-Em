event_inherited();

special_allowed_chars = [ord("'"), vk_space];

ip_request = noone;
func = function()
{
	if ip_request { exit; }
	ip_request = http_get("https://api.ipify.org");
}