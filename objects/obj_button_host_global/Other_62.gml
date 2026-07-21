if async_load[? "id"] != ip_request || async_load[? "status"] != 0 { exit; }

ip = async_load[? "result"];