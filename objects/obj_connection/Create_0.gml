carried_wss = false;
wss = network_create_socket(network_socket_wss);
if wss < 0 { instance_destroy(); }

network_connect_raw_async(wss, "wss://drop-em-server.onrender.com/", 443);