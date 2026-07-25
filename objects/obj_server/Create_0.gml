event_user(0);
tcp = create_server(network_socket_tcp);
udp = create_server(network_socket_udp);

//First client is the host themself
clients =
[{
	tcp,
	ip: public_ip,
	tcp_port: PORT,
	udp_port: PORT,
	last_alive: current_time,
	frame_inputs:
	{
		input_pressed: inputs_default(),
		input_held: inputs_default(),
		input_released: inputs_default()
	}
}];

discovery_data = buffer_struct
({
	type: NETWORK_TYPES.DISCOVERY,
	name: "Insert name",
	creation_time: EPOCH_TIME
});

object_data = [];

if tcp < 0 || udp < 0 { instance_destroy(); exit; }

var ip_octets = string_split(public_ip, ".");
var join_buff = buffer_create(4, buffer_fixed, 1);
buffer_write(join_buff, buffer_u8, real(ip_octets[0]));
buffer_write(join_buff, buffer_u8, real(ip_octets[1]));
buffer_write(join_buff, buffer_u8, real(ip_octets[2]));
buffer_write(join_buff, buffer_u8, real(ip_octets[3]));
	
join_code = buffer_base64_encode(join_buff, 0, 4);
join_code = string_replace_all(join_code, "=", "");
buffer_delete(join_buff);