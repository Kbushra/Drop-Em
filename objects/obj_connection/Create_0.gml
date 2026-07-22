event_user(0);
tcp = network_create_socket(network_socket_tcp);
udp = network_create_socket(network_socket_udp);
if tcp < 0 || udp < 0 { instance_destroy(); exit; }

broadcast_data = buffer_struct({ type: NETWORK_TYPES.DISCOVERY });
servers = {};
server = {};