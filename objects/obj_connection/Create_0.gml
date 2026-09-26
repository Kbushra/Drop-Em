carried_wss = false;
wss = NONE;

if instance_exists(create_object) { instance_destroy(); exit; }

wss = network_create_socket(network_socket_wss);
if wss < 0 { instance_destroy(); }

network_connect_raw_async(wss, "wss://dropemserver.onrender.com/", 443);