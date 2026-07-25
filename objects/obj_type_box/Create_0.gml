initial_keyboard_string = keyboard_string;
typed_string = "";

func = empty;

special_allowed_chars = [ord("+"), ord("/")];

///@func add_char(c)
add_char = function(c)
{
	if string_length(typed_string) >= 8 { exit; }
	
	var spamming = last_ascii == c && hold_time <= 0;
	if keyboard_check_pressed(c) || spamming
	{
		typed_string += chr(c);
		last_ascii = c;
		hold_time = spamming ? 2 : 30;
	}
}