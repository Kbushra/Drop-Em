client_spawn = function() { instance_create_depth(x, y, depth, obj_connection, { create_object: obj_client }); };
client_destroy = function() { instance_destroy(obj_connection); instance_destroy(obj_client); }

full_path =
[
	{
		obj: obj_button_advance,
		vars: { name: "HOST" },
		path:
		[
			{
				obj: obj_button_back
			},
			{
				obj: obj_type_box_host
			}
		]
	},
	{
		obj: obj_button_advance,
		vars: { name: "JOIN" },
		func: client_spawn,
		path:
		[
			{
				obj: obj_button_back,
				func: client_destroy
			},
			{
				obj: obj_type_box_join
			},
			{
				obj: obj_panel_lan
			}
		]
	},
	{
		obj: obj_button_playground
	}
];

indices = [];
active_ui = true;

event_user(0);
create_ui();