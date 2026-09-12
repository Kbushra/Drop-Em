if !focused { exit; }

if keyboard_check_pressed(ord("V")) && keyboard_check(vk_control)
{ keyboard_string = initial_keyboard_string + typed_string + clipboard_get_text(); }

if string_length(keyboard_string) < string_length(initial_keyboard_string)
{ initial_keyboard_string = keyboard_string; }

typed_string = "";
for (var i = string_length(initial_keyboard_string) + 1; i <= string_length(keyboard_string); i++)
{
	var ascii = ord(string_char_at(keyboard_string, i));
	if limit == NONE && string_width(typed_string + chr(ascii)) >= sprite_width - 10 { break; }
	if limit >= 0 && string_length(typed_string) >= limit { break; }
	
	if ascii == clamp(ascii, ord("A"), ord("Z")) || ascii == clamp(ascii, ord("a"), ord("z")) ||
	ascii == clamp(ascii, ord("0"), ord("9")) || array_contains(special_chars, ascii)
	{
		typed_string += chr(ascii);
	}
}

keyboard_string = initial_keyboard_string + typed_string;
with type_bar
{
	x = other.x + 2;
	y = other.y + other.sprite_height/2;
	if typed_string != other.typed_string { image_index = 0; }
	typed_string = other.typed_string;
}