event_inherited();

func = function()
{
	if string_length(typed_string) != 6 || obj_connection.server_ip != "" { exit; }
	
	var ip_buff = buffer_base64_decode($"{typed_string}==");
	var ip_octets = [];
	ip_octets[0] = buffer_read(ip_buff, buffer_u8);
	ip_octets[1] = buffer_read(ip_buff, buffer_u8);
	ip_octets[2] = buffer_read(ip_buff, buffer_u8);
	ip_octets[3] = buffer_read(ip_buff, buffer_u8);
	var ip = string_join_ext(".", ip_octets);
	
	print(ip);
	obj_connection.server_ip = ip;
	network_connect_async(obj_connection.tcp, obj_connection.server_ip, PORT);
}