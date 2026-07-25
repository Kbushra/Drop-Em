if keyboard_check_pressed(ord("V")) && keyboard_check(vk_control)
{ keyboard_string += clipboard_get_text(); }

if string_length(keyboard_string) < string_length(initial_keyboard_string)
{ initial_keyboard_string = keyboard_string; }

typed_string = "";
for (var i = string_length(initial_keyboard_string) + 1; i <= string_length(keyboard_string); i++)
{
	if limit == NONE && string_width(typed_string) >= sprite_width * 0.9 { break; }
	if limit >= 0 && string_length(typed_string) >= limit { break; }
	
	var ascii = ord(string_char_at(keyboard_string, i));
	if ascii == clamp(ascii, ord("A"), ord("Z")) || ascii == clamp(ascii, ord("a"), ord("z")) ||
	ascii == clamp(ascii, ord("0"), ord("9")) || array_contains(special_allowed_chars, ascii)
	{
		typed_string += chr(ascii);
	}
}

keyboard_string = initial_keyboard_string + typed_string;