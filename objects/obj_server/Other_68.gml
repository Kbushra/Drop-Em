if async_load[? "type"] != network_type_data { exit; }

var data = json_parse(buffer_read(async_load[? "buffer"], buffer_string));

if data.type == NETWORK_TYPES.DISCOVERY
{
	network_send_udp(async_load[? "id"], async_load[? "ip"], async_load[? "port"],
		broadcast_data.buffer, broadcast_data.len);
}