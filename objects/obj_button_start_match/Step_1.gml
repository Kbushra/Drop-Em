visible = !instance_exists(obj_panel_hosting);
name = array_length(obj_host.clients) == 1 ?
	"START SOLO" : $"START ({array_length(obj_host.clients)}/8)";