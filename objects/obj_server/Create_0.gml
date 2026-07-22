event_user(0);
tcp = create_server(network_socket_tcp);
udp = create_server(network_socket_udp);

discovery_data = buffer_struct
({
	type: NETWORK_TYPES.DISCOVERY,
	name: "Insert name",
	creation_time: EPOCH_TIME
});

if tcp < 0 || udp < 0 { instance_destroy(); exit; }

var ip_octets = string_split(ip, ".");
var join_buff = buffer_create(4, buffer_fixed, 1);
buffer_write(join_buff, buffer_u8, real(ip_octets[0]));
buffer_write(join_buff, buffer_u8, real(ip_octets[1]));
buffer_write(join_buff, buffer_u8, real(ip_octets[2]));
buffer_write(join_buff, buffer_u8, real(ip_octets[3]));
	
join_code = buffer_base64_encode(join_buff, 0, 4);
join_code = string_replace_all(join_code, "=", "");
buffer_delete(join_buff);