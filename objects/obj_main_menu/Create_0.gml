full_path =
[
	{
		button: obj_button_host,
		name: "HOST"
	},
	{
		button: obj_button_advance,
		name: "JOIN",
		path:
		[
			{
				button: obj_button_back,
				name: "BACK"
			},
			{
				button: obj_button_join_local,
				name: "LOCAL"
			},
			{
				button: obj_button_join_global,
				name: "GLOBAL"
			}
		]
	},
	{
		button: obj_button_playground,
		name: "TEST"
	}
];

indices = [];

event_user(0);
create_buttons();