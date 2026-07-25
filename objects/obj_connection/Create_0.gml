event_user(0);
tcp = network_create_socket(network_socket_tcp);
udp = network_create_socket(network_socket_udp);
if tcp < 0 || udp < 0 { instance_destroy(); exit; }

discovery_data = buffer_struct({ type: NETWORK_TYPES.DISCOVERY });
servers = {};
server_ip = "";
server_last_alive = current_time;
connected = false;
client_id = NONE;